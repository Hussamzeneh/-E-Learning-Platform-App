import 'dart:convert';
import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled4/services/verify_code_services.dart';

import '../helper/network.dart';

class RessetPasswordServices {
  static Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',

  };

  static const resetpassword = "resetpassword";
  final String url;
  RessetPasswordServices(this.url);
  static Future<bool> sendNewPassword(String newPassword) async {
    late http.Response response;
    String data = "";
    try {

      response = await NetworkUtils.post(
        headers: headers,
        url: resetpassword,
        body: jsonEncode({
          'password': newPassword,
          'token_code':ViryfiCodeServices.token_code
          }),
      );
      if (response.statusCode == 200) {
        log(response.statusCode.toString(), name: "post StatusCode");
        log(response.body.toString(), name: "post Body");
        var data = jsonDecode(response.body);

        return true;
      } else {
        // log("${response.statusCode}", name: "post StatusCode");
        // log("${response.body}", name: "post Body");
        var dataDecoded = jsonDecode(response.body);
        data = dataDecoded["message"];

        return false;
      }
    } catch (e) {

      return false;
    }

    // return data;
  }
}
