import 'dart:convert';
import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../helper/network.dart';

class PayFeeServices {
  static Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization':NetworkUtils.token
  };

  static const paid_fee = "paid_fee";
  final String url;
  PayFeeServices(this.url);
  static Future payFee(int fee_id) async {
    late http.Response response;
     String data = "";
    try {
      //BotToast.showLoading();
      response = await NetworkUtils.post(
        headers: headers,
        url: paid_fee,
        body: jsonEncode({'fee_id': fee_id}),
      );
      log("${response.statusCode}", name: "post Body");

      if (response.statusCode == 200) {
        log(response.statusCode.toString(), name: "post StatusCode");
        log(response.body.toString(), name: "post Body");
        var data = jsonDecode(response.body);
        print(data["message"]);
        print(response.statusCode);
        // BotToast.showText(
        //   text: data["message"],
        //   align: Alignment.center,
        //   duration: Duration(seconds: 2),
        // );
        return data;
      } else {
        log("${response.statusCode}", name: "post StatusCode");
        log("${response.body}", name: "post Body");
        var dataDecoded = jsonDecode(response.body);
        data = dataDecoded["message"];
        // BotToast.showText(
        //   text: "Failed to pay :" + data,
        //   align: Alignment.center,
        //   duration: Duration(seconds: 2),
        // );
        print(data);
        return data;
      }
    } catch (e) {
      // BotToast.showText(
      //   text: e == data
      //       ? e.toString()
      //       : "Something went wrong, Please try again later",
      //   align: Alignment.center,
      //   duration: Duration(seconds: 2),
      // );
      return data;
    }
    // finally{
    //   BotToast.closeAllLoading();
    // }
    // // return data;
  }
}
