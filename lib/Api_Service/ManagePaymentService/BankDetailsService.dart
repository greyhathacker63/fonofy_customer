import 'dart:convert';
import 'dart:developer';
import 'package:fonofy/Services/web_constants.dart';
import 'package:fonofy/model/ManagePaymentsModel/BandDetailsModel.dart';
import 'package:http/http.dart' as http;
import '../../TokenHelper/TokenHelper.dart';

class BankApiResult<T> {
  final bool success;
  final T data;
  final String? errorMessage;

  BankApiResult({required this.success, required this.data, this.errorMessage});
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
      log("Token is null or expired, attempting to refresh");
      token = await refreshToken(userCode);
      if (token == null) {
        log("Token refresh failed");
        return false;
      }
    }

    final String url = "$baseurl$b2c/add-bank-details";
    log("Calling addBankDetails API: $url");

    try {
      if (requestModel.accountNumber != requestModel.confirmAccountNumber) {
        log("Account number and confirm account number do not match");
        return false;
      }

      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestModel.toJson()),
      );

      log("addBankDetails response: ${response.statusCode} - ${response.body}");

      if (response.statusCode == 200) {
        if (response.body.trim() == '"Successful"') {
          log("Add Bank Success: Response is a plain string 'Successful'");
          return true;
        }
        try {
          var res = jsonDecode(response.body);
          if (res is Map<String, dynamic>) {
            log("Add Bank Success: ${res["message"] ?? "No message in response"}");
          } else {
            log("Add Bank Success: Response is not a JSON object");
          }
          return true;
        } catch (e) {
          log("Add Bank Success but could not parse response as JSON: ${response.body}, Error: $e");
          return true;
        }
      } else if (response.statusCode == 401 && retryCount < maxRetries) {
        log("Received 401, attempting to refresh token (retry $retryCount/$maxRetries)");
        token = await refreshToken(userCode);
        if (token == null) {
          log("Token refresh failed after 401");
          return false;
        }
        return await addBankDetails(requestModel, retryCount: retryCount + 1);
      } else {
        log("Add Bank Error ${response.statusCode}: ${response.body}");
        return false;
      }
    } catch (e) {
      log("Add Bank Exception: $e");
      return false;
    }
  }

  static Future<BankApiResult<List<BankDetails>>> getBankDetailsList(
      {int retryCount = 0}) async {
    const maxRetries = 3;
    final customerId = await TokenHelper.getUserCode();
    if (customerId == null) {
      log("Customer ID not found");
      return BankApiResult(
          success: false, data: [], errorMessage: "Customer ID not found");
    }

    String? token = await TokenHelper.getToken();
    if (token == null || isTokenExpired(token)) {
      log("Token is null or expired, attempting to refresh");
      token = await refreshToken(customerId);
      if (token == null) {
        log("Token refresh failed");
        return BankApiResult(
            success: false, data: [], errorMessage: "Token refresh failed");
      }
    }

    // Changed endpoint to /bank-details and query parameter to CustomerId
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
        log("Bank List Response: $data");
        final bankList = (data['Table'] as List<dynamic>?)
                ?.map((item) =>
                    BankDetails.fromJson(item as Map<String, dynamic>))
                .toList() ??
            [];
        return BankApiResult(success: true, data: bankList);
      } else if (response.statusCode == 401 && retryCount < maxRetries) {
        log("Received 401, attempting to refresh token (retry $retryCount/$maxRetries)");
        token = await refreshToken(customerId);
        if (token == null) {
          log("Token refresh failed after 401");
          return BankApiResult(
              success: false,
              data: [],
              errorMessage: "Token refresh failed after 401");
        }
        return await getBankDetailsList(retryCount: retryCount + 1);
      } else {
        log("Get Bank List Failed: ${response.statusCode} - ${response.body}");
        return BankApiResult(
            success: false,
            data: [],
            errorMessage:
                "Failed to fetch bank details: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      log("Get Bank List Exception: $e");
      return BankApiResult(
          success: false,
          data: [],
          errorMessage: "Exception while fetching bank details: $e");
    }
  }

  static bool isTokenExpired(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) {
        log("Invalid JWT format: token does not have 3 parts");
        return true;
      }

      final payload = json.decode(
        utf8.decode(
          base64Url.decode(base64Url.normalize(parts[1])),
        ),
      );

      final exp = payload['exp'] as int?;
      if (exp == null) {
        log("Token payload does not contain 'exp' field");
        return true;
      }

      final expiryDate = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      final isExpired = DateTime.now().isAfter(expiryDate);
      if (isExpired) {
        log("Token expired: expiryDate=$expiryDate, now=${DateTime.now()}");
      }
      return isExpired;
    } catch (e) {
      log("Error decoding token: $e");
      return true;
    }
  }

  static Future<String?> refreshToken(String userCode) async {
    final String refreshTokenUrl = "$baseurl/refresh-token";
    log("Calling refreshToken API: $refreshTokenUrl");

    try {
      var response = await http.post(
        Uri.parse(refreshTokenUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'mobile': userCode}),
      );

      log("refreshToken response: ${response.statusCode} - ${response.body}");

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        String? newToken = data['token'];
        if (newToken == null) {
          log("Token not found in refresh token response: ${response.body}");
          return null;
        }
        await TokenHelper.saveToken(newToken);
        log("Token refreshed successfully");
        return newToken;
      } else {
        log("Token refresh failed: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      log("Token refresh error: $e");
      return null;
    }
  }
}
