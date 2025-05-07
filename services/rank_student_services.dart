import 'dart:convert';
import 'dart:developer';


import 'package:http/http.dart' as http;

import '../Model/models/rank_student_model.dart';

import '../helper/network.dart';

class RankStudentServices {
  static Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization':NetworkUtils.token
        };

  static const rank = "rank";
  final String url;
  RankStudentServices(this.url);
  static Future<List<RankModel>> getRank() async {
    List<dynamic> _responseList = [];
    List<RankModel> modelList = [];
    
      try {
        http.Response response =
            await NetworkUtils.get(url: rank, headers: headers);
        if (response.statusCode == 200) {
          log(response.body.toString(), name: "getTotalRank response");
          _responseList = json.decode(response.body);
          modelList =
              _responseList.map((e) => RankModel.fromJson(e)).toList();
          return modelList;
        } else {
          log(response.statusCode.toString(), name: "getTotalRank api error");
          return modelList;
        }
      } catch (e) {

      }
      return modelList;

    }
  }
  
