import 'dart:convert';
import 'dart:developer';
import 'package:fonofy/Services/web_constants.dart';
import 'package:fonofy/model/ManagePaymentsModel/BankDetailsModel.dart';
import 'package:http/http.dart' as http;
import '../../TokenHelper/TokenHelper.dart';

class BankApiResult<T> {
  final bool success;
  final T data;
  final String? errorMessage;

  BankApiResult({required this.success, required this.data, this.errorMessage});
}

class CombinedBankUpiResult {
  final List<BankDetails> bankDetails;
  final List<UpiDetails> upiDetails;

  CombinedBankUpiResult({required this.bankDetails, required this.upiDetails});
}

class BankService {
  static Future<bool> addBankDetails(BankDetailsRequest requestModel,
      {int retryCount = 0}) async {
    const maxRetries = 3;
    final userCode = await TokenHelper.getUserCode();
    if (userCode == null) {
      log("User code is null");
      return false;
    }

    String? token = await TokenHelper.getToken();
    if (token == null || isTokenExpired(token)) {
      token = await refreshToken(userCode);
      if (token == null) return false;
    }

    final String url = "$baseurl${b2c}add-bank-details";
    log("Calling addBankDetails API: $url");

    if (requestModel.accountNumber != requestModel.confirmAccountNumber) {
      log("Account number and confirm account number do not match");
      return false;
    }

    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestModel.toJson()),
      );

      log("addBankDetails response: ${response.statusCode} - ${response.body}");

      if (response.statusCode == 200 &&
          response.body.trim() == '"Successful"') {
        return true;
      }
      return false;
    } catch (e) {
      log("Add Bank Exception: $e");
      return false;
    }
  }

  static Future<BankApiResult<CombinedBankUpiResult>> getBankDetailsList(
      {int retryCount = 0}) async {
    const maxRetries = 3;
    final customerId = await TokenHelper.getUserCode();
    if (customerId == null) {
      return BankApiResult(
          success: false,
          data: CombinedBankUpiResult(bankDetails: [], upiDetails: []),
          errorMessage: "Customer ID not found");
    }

    String? token = await TokenHelper.getToken();
    if (token == null || isTokenExpired(token)) {
      token = await refreshToken(customerId);
      if (token == null) {
        return BankApiResult(
            success: false,
            data: CombinedBankUpiResult(bankDetails: [], upiDetails: []),
            errorMessage: "Token refresh failed");
      }
    }

    final String url = "$baseurl$b2c$getBankDetails?customerId=$customerId";
    log("Calling getBankDetailsList API: $url");

    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      log("getBankDetailsList response: ${response.statusCode} - ${response.body}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        final List<BankDetails> bankList = (data['Table'] as List<dynamic>?)
                ?.map((item) => BankDetails.fromJson(item))
                .toList() ??
            [];

        final List<UpiDetails> upiList = (data['Table1'] as List<dynamic>?)
                ?.map((item) => UpiDetails.fromJson(item))
                .toList() ??
            [];

        return BankApiResult(
          success: true,
          data:
              CombinedBankUpiResult(bankDetails: bankList, upiDetails: upiList),
        );
      } else if (response.statusCode == 401 && retryCount < maxRetries) {
        token = await refreshToken(customerId);
        if (token != null) {
          return await getBankDetailsList(retryCount: retryCount + 1);
        }
      }

      return BankApiResult(
        success: false,
        data: CombinedBankUpiResult(bankDetails: [], upiDetails: []),
        errorMessage: "Failed to fetch data: ${response.statusCode}",
      );
    } catch (e) {
      log("Get Bank List Exception: $e");
      return BankApiResult(
        success: false,
        data: CombinedBankUpiResult(bankDetails: [], upiDetails: []),
        errorMessage: "Exception occurred: $e",
      );
    }
  }

  static bool isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return true;

      final payload = json
          .decode(utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
      final exp = payload['exp'] as int?;
      if (exp == null) return true;

      return DateTime.now()
          .isAfter(DateTime.fromMillisecondsSinceEpoch(exp * 1000));
    } catch (e) {
      return true;
    }
  }

  static Future<String?> refreshToken(String userCode) async {
    final String refreshTokenUrl = "$baseurl/refresh-token";
    try {
      var response = await http.post(
        Uri.parse(refreshTokenUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'mobile': userCode}),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String? newToken = data['token'];
        if (newToken != null) {
          await TokenHelper.saveToken(newToken);
          return newToken;
        }
      }
      return null;
    } catch (_) {
      return null;
    }
  }

  static Future<bool> deleteBankDetails(int id) async {
    final customerId = await TokenHelper.getUserCode();
    if (customerId == null) {
      log("Customer ID not found");
      return false;
    }

    String? token = await TokenHelper.getToken();
    if (token == null || isTokenExpired(token)) {
      token = await refreshToken(customerId);
      if (token == null) {
        log("Token refresh failed");
        return false;
      }
    }

    // Construct the API URL correctly
    final String url =
        "$baseurl${b2c}delete-bank-details?Id=$id&CustomerId=$customerId";
    log("Calling deleteBankDetails API: $url");

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      log("deleteBankDetails response: ${response.statusCode} - ${response.body}");

      return response.statusCode == 200 &&
          response.body.trim().contains("Successful");
    } catch (e) {
      log("Delete Bank Exception: $e");
      return false;
    }
  }
}
