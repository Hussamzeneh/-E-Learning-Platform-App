import 'dart:convert';
import 'dart:developer';



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../helper/network.dart';

class ForgotPasswordServices {
  static Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };

  static const passwordforget = "passwordforget";
  final String url;
  ForgotPasswordServices(this.url);
  static Future<bool> sendEmail(String email) async {
    late http.Response response;
    String data = "";
    try {

      response = await NetworkUtils.post(
        headers: headers,
        url: passwordforget,
        body: jsonEncode({'email': email}),
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
