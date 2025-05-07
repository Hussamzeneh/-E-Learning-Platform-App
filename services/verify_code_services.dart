import 'dart:convert';
import 'dart:developer';



import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../helper/network.dart';

class ViryfiCodeServices {
  static Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
  };
  static var token_code = '';
  static const checkcodepassword = "checkcodepassword";
  final String url;
  ViryfiCodeServices(this.url);
  static Future<bool> sendCode(String code) async {
    late http.Response response;
    String data = "";
    try {

      response = await NetworkUtils.post(
        headers: headers,
        url: checkcodepassword,
        body: jsonEncode({'code': code}),
      );
      if (response.statusCode == 200) {
        log(response.statusCode.toString(), name: "post StatusCode");
        log(response.body.toString(), name: "post Body");
        var data = jsonDecode(response.body);
          token_code = data["token_code"] ; 

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
