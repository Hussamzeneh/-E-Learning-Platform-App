import 'dart:convert';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:untitled4/Cubit/Login%20cubit/profilecubit.dart';

import '../Model/models/advertisement_model.dart';
import '../helper/network.dart';

class AdvertisementServices {
  static Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-Type': 'application/json',
    'Authorization' : 'Bearer ${firebasetoken1}' ,
  };

  static const show_all_by_class = "show_all_by_class";
  final String url;
  AdvertisementServices(this.url);

  static Future<AdvertisementModel> getAdvertisement() async {
    try {
      dynamic _responseMap;
      AdvertisementModel _inspection;
      http.Response response = await NetworkUtils.get(
          url: "$show_all_by_class", headers: headers);
      if (response.statusCode == 200) {
        log(response.body.toString(), name: "getServiceDetails response");
        _responseMap = json.decode(response.body);
       var mapelment = jsonDecode(response.body);


        // List buses = [];
        // List exams = [];
        // for (var item in mapelment) {
        //   if (item['type'] == 'bus') {
        //     print('/////////////////');
        //     buses.add(item);
        //   } else if (item['type'] == 'exam') {
        //     exams.add(item);
        //   }
        // }
        // print(buses);
        // print(exams);
        _inspection = AdvertisementModel.fromJson(_responseMap);

        return _inspection;
      } else {
        log(response.statusCode.toString(),
            name: "Get getServiceDetails api error");
        return AdvertisementModel();
      }
    } catch (e) {
      print(e);
      return AdvertisementModel();
    }
  }
}
