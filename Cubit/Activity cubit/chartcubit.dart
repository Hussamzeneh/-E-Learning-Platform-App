import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:http/http.dart' as http;
import 'package:untitled4/Cubit/Login%20cubit/profilecubit.dart';

import 'package:untitled4/Model/models/activitymodel.dart';

import '../../constans.dart';
import 'chartstate.dart';



class chartcubit extends Cubit<chartstate> {
  chartcubit() : super(initialchart()) {
    getactivity();
  }

  activitymodel? chart ;

  Future<activitymodel?> getactivity() async {
    emit(loadingchart());

    http.Response response = await http.get(
        Uri.parse('http://${KURL}:8000/api/activity'),
        headers: {'Authorization': 'Bearer ${firebasetoken1}'});

    if (response.statusCode == 200) {
      print('44444444444444444');

      emit(succeschart());
      Map<String, dynamic> data = jsonDecode(response.body);
      print(data);

      chart = activitymodel.fromJson(data);
      print('its done  ${chart?.task_percentage}');
      print('================0');
      print(chart);

      return chart;
    } else {
      return chart;
    }
  }
}
