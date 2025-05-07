import 'dart:convert';
import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:untitled4/Model/models/get_grades_by_type_model.dart';
import 'package:untitled4/helper/network.dart';

import '../Cubit/Login cubit/profilecubit.dart';

class ShowDetileGradeServices {
  static Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization' :'Bearer $firebasetoken1'

  };
  static var token_code = '';
  static const show_grade_by_type = "show_grade_by_type";
  final String url;
  ShowDetileGradeServices(this.url);
 static  Future<List<GradesByType>> sendType(String type , String subjectName) async {
    List<dynamic> _responseList = [];
    List<GradesByType> modelList = [];
    late http.Response response;
    String data = "";

      // BotToast.showLoading();
      response = await NetworkUtils.post(
        headers: headers,
        url: show_grade_by_type,
        body: jsonEncode({
          'type':type,
          'subject_name':subjectName
          }),
      );
      if (response.statusCode == 200) {
        print('999999999999999999999999999999');
        print(response.body);
        log(response.body.toString(), name: "Grade response");
        _responseList = jsonDecode(response.body);
        modelList =_responseList.map((e) => GradesByType.fromJson(e)).toList();
        print('mooooooooooooooooooodrl');
        print(modelList);
        log(modelList.toString(),name: "gh");

        return modelList;
      } else {
        // log("${response.statusCode}", name: "post StatusCode");
        // log("${response.body}", name: "post Body");
        var dataDecoded = jsonDecode(response.body);
        data = dataDecoded["message"];
        // BotToast.showText(
        //   text: "Failed to send email:" + data,
        //   align: Alignment.center,
        //   duration: Duration(seconds: 2),
        // );
        return modelList;
      }


    // return data;
  }
}
