//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:fonofy/model/phone_model.dart';
//
// class PhoneApiService {
//   // Here, you should assign the actual token you want to pass
//   final String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9."
//       "eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9tb2JpbGVwaG9uZSI6InNhbXBsZSBzdHJpbmcgNCIsImh0dHA6Ly9zY2"
//       "hlbWFzLnhtbHNvYXAub3JnL3dzLzIwMDUvMDUvaWRlbnRpdHkvY2xhaW1zL25hbWUiOiJzYW1wbGUgc3RyaW5nIDEiLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93"
//       "cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9lbWFpbGFkZHJlc3MiOiJzYW1wbGUgc3RyaW5nIDMiLCJMb2dpblRpbWUiOiIzLzIxLzIwMjUgNDoxMDo0NiBQTSIsIm5iZ"
//       "iI6MTc0MjU1MzY0NiwiZXhwIjoxNzQyNTU1NDQ2LCJpc3MiOiJTaGl2YW0gU2hhcm1hIiwiYXVkIjoiRm9ub0FwaSJ9.xdygxqYtxETybQf33QChs3Sj9mkMMJXGes-ScA_-XgA";
//
//   // Function to make a GET request to the API
//   Future<PhoneModel> phoneNumber() async {
//     final response = await http.get(
//       Uri.parse('https://api.fonofy.in/api/common/check-mobile-number?mobileNumber=9135609361'),
//       headers: {
//         'Authorization': 'Bearer $token',// Using the token in Authorization header
//       },
//     );
//
//     if (response.statusCode == 200) {
//       // If the response is successful (200 OK), decode the JSON and return a PhoneModel
//       var responseData = jsonDecode(response.body);
//       return PhoneModel.fromJson(responseData); // Assuming you have a fromJson constructor in PhoneModel
//     } else {
//       // If the response is not successful, handle the error or return an empty PhoneModel
//       print("Failed to load data: ${response.statusCode}");
//
//     }
//   }
// }
//
