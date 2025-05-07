import 'dart:convert';
import 'dart:developer';


import 'package:http/http.dart' as http;
import 'package:untitled4/services/show_fees.dart';

import '../helper/network.dart';


class ShowFeesServices {
  static Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization':NetworkUtils.token  };

  static const show_fees = "show_fees";
  final String url;
  ShowFeesServices(this.url);

  static Future<List<ShowFees>> getTotalFees() async {
    List<dynamic> _responseList = [];
    List<ShowFees> modelList = [];
      try {
        http.Response response =
            await NetworkUtils.get(url: show_fees, headers: headers);
        if (response.statusCode == 200) {
          log(response.body.toString(), name: "getTotalGrade response");
          _responseList = json.decode(response.body);
          modelList =
              _responseList.map((e) => ShowFees.fromJson(e)).toList();
          return modelList;
        } else {
          log(response.statusCode.toString(), name: "getFee api error");
          return modelList;
        }
      } catch (e) {

      }
      return modelList;
     
  }
  
}
