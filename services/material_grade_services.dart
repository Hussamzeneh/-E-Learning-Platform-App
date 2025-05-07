import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../Cubit/Login cubit/profilecubit.dart';
import '../Model/models/material_grade_model.dart';
import '../helper/network.dart';

class MaterialGradeServices {
  static Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization':
    'Bearer ${firebasetoken1}'
  };

  static const show_the_total_grade = "show_the_total_grade";
  final String url;
  MaterialGradeServices(this.url);
  // static Future<MaterialGrade> getTotalGrade() async {
  //   try {
  //     dynamic _responseMap;
  //     MaterialGrade _inspection;
  //     http.Response response = await NetworkUtils.get(
  //         url: "$show_the_total_grade", headers: headers);
  //     if (response.statusCode == 200) {
  //       log(response.body.toString(), name: "getTotalGrade response");
  //       _responseMap = json.decode(response.body);
  //       _inspection = MaterialGrade.fromJson(_responseMap[0]);
  //       return _inspection;
  //     } else {
  //       log(response.statusCode.toString(),
  //           name: "Get getTotalGrade api error");
  //       return MaterialGrade();
  //     }
  //   } catch (e) {
  //     print(e);
  //     return MaterialGrade();
  //   }
  // }
  static Future<List<MaterialGrade>> getTotalGrade() async {
    List<dynamic> _responseList = [];
    List<MaterialGrade> modelList = [];
     try {
        http.Response response =
            await NetworkUtils.get(url: show_the_total_grade, headers: headers);
        if (response.statusCode == 200) {
          log(response.body.toString(), name: "getTotalGrade response");
          _responseList = json.decode(response.body);
          modelList =
              _responseList.map((e) => MaterialGrade.fromJson(e)).toList();
          return modelList;
        } else {
          log(response.statusCode.toString(), name: "getTotalGrade api error");
          return modelList;
        }
      } catch (e) {

      }
      return modelList;
    }
  }
  // static Future<bool> sendEmail(String email) async {
  //   late http.Response response;
  //   String data = "";
  //   try {
  //     BotToast.showLoading();
  //     response = await NetworkUtils.get(
  //       headers: headers,
  //       url: show_the_total_grade,
  //     );
  //     if (response.statusCode == 200) {
  //       log(response.statusCode.toString(), name: "post StatusCode");
  //       log(response.body.toString(), name: "post Body");
  //       var data = jsonDecode(response.body);
  //       BotToast.showText(
  //         text: data["message"],
  //         align: Alignment.center,
  //         duration: Duration(seconds: 2),
  //       );
  //       return true;
  //     } else {
  //       // log("${response.statusCode}", name: "post StatusCode");
  //       // log("${response.body}", name: "post Body");
  //       var dataDecoded = jsonDecode(response.body);
  //       data = dataDecoded["message"];
  //       BotToast.showText(
  //         text: "Failed to send email:" + data,
  //         align: Alignment.center,
  //         duration: Duration(seconds: 2),
  //       );
  //       return false;
  //     }
  //   } catch (e) {
  //     BotToast.showText(
  //       text: e == data
  //           ? e.toString()
  //           : "Something went wrong, Please try again later",
  //       align: Alignment.center,
  //       duration: Duration(seconds: 2),
  //     );
  //     return false;
  //     throw (e == data ? e : "Something went wrong, Please try again later");
  //   }
  //   finally{
  //     BotToast.closeAllLoading();
  //   }
  //   // return data;
  // }

