import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:untitled4/Cubit/ADV%20cubit/neawadvstates.dart';
import 'package:http/http.dart' as http;

import 'package:untitled4/Model/neadvmodel.dart';

import '../../constans.dart';
import '../Login cubit/profilecubit.dart';

class newadvcubit extends Cubit<newadvstates> {
  newadvcubit() : super(advintial()) {
    getadv();
  }

  NewAdvModel? Newmodel;
  List<NewAdvModel> advlist = [];
  List<NewAdvModel> buses = [];
  List<NewAdvModel> exams = [];
  List<NewAdvModel> journy = [];
  List<NewAdvModel> wallet = [];
  List<NewAdvModel> student = [];
  List<NewAdvModel> instructions = [];

  Future getadv() async {
    try {
      emit(advloading());

      http.Response response = await http.get(
          Uri.parse('http://$KURL:8000/api/Advertisements'),
          headers: {'Authorization': 'Bearer $firebasetoken1'});
      var data = jsonDecode(response.body);
      data.forEach((element) => advlist.add(NewAdvModel.fromJson(element)));
      data.forEach((element) => Newmodel = NewAdvModel.fromJson(element));
      var data1 = jsonDecode(response.body);
      for (var item in data1) {
        final newAdvModel = NewAdvModel.fromJson(item);
        if (newAdvModel.type == 'bus') {
          buses.add(newAdvModel);
        } else if (newAdvModel.type == 'exam') {
          exams.add(newAdvModel);
        } else if (newAdvModel.type == 'trip') {
          journy.add(newAdvModel);
        } else if (newAdvModel.type == 'wallet') {
          wallet.add(newAdvModel);
        } else if (newAdvModel.type == 'student') {
          student.add(newAdvModel);
        }
        else if (newAdvModel.type == 'instuctions') {
          instructions.add(newAdvModel);
        }
      }
      emit(advsucces());
    } catch (e) {
      emit(advfeuliur());
    }
  }
}
