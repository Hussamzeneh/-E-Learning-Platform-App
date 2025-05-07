import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:untitled4/Cubit/Subject%20cubit/subjectstates.dart';
import 'package:untitled4/Model/subjectmodel.dart';
import 'package:http/http.dart' as http;

import '../../constans.dart';

String subjectclassid = '7';

class subjectcubit extends Cubit<subjectstate> {
  subjectcubit() : super(subjectinitial()) {
    getallproduct(classid: '7');
  }
  Set<Subjectmodel> subjectlists7 = {};
  Subjectmodel? subjectmodel;



  Future<Set<Subjectmodel>?> getallproduct({required String classid}) async {
    emit(subjectloading());

  try{
    http.Response response = await http.post(
        Uri.parse('http://${KURL}:8000/api/show_subjects_of_the_class'),
        body: {'class_level': classid});

    var data = jsonDecode(response.body);



    subjectlists7.clear();
    data.forEach(
            (element) => subjectlists7.add(Subjectmodel.fromJson(element)));
    data.forEach((element) => subjectmodel = Subjectmodel.fromJson(element));
    print(data);
    emit(subjectsucces());

    return subjectlists7.toSet();


  }
  catch(e){
    emit(subjectfeuliur());
  }
  }

}
