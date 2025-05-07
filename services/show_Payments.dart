import 'dart:convert';
import 'dart:developer';


import 'package:http/http.dart' as http;

import '../Model/models/show_payments_model.dart';
import '../helper/network.dart';

class GetPaymentsServices {
  static Map<String, String> headers = {

    'Authorization' :NetworkUtils.token
  };

  static const show = "show";
  final String url;
  GetPaymentsServices(this.url);

  static Future<ShowPaymentsModel> GetPayments() async {
    try {
      dynamic _responseMap;
      ShowPaymentsModel _inspection;

      http.Response response = await NetworkUtils.get(
          url: "$show", headers: headers);
      print(response.statusCode);
      if (response.statusCode == 200) {
        log(response.body.toString(), name: "getServiceDetails response");
        _responseMap = json.decode(response.body);
        _inspection = ShowPaymentsModel.fromJson(_responseMap);
        return _inspection;
      } else {
        log(response.statusCode.toString(),
            name: "Get getServiceDetails api error");
        return ShowPaymentsModel();
      }
    } catch (e) {
      print(e);
      return ShowPaymentsModel();
    }

  }  
}
