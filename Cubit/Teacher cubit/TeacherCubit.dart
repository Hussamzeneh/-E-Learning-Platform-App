import 'dart:convert';

import 'package:bloc/bloc.dart';

import 'package:http/http.dart' as http;
import 'package:untitled4/Cubit/Login%20cubit/profilestates.dart';
import '../../Model/TeacherProfileModel.dart';
import '../../constans.dart';
import 'TeacherStates.dart';
String? classnumberteacher1 = '7';
class TeacherCubit extends Cubit<TeacherStates> {
  TeacherCubit() : super(initialstte()) {
    getallproduct(classid: '7');
  }

  orginalteachermodel? teacherProfileModel;
  Set<orginalteachermodel> productlists7 = {};
  Future<Set<orginalteachermodel>?> getallproduct(
      {required String classid}) async {
    emit(Loading());

  try{

    http.Response response = await http.post(
        Uri.parse('http://${KURL}:8000/api/show_teachers_by_class'),
        body: {'class_level': classid});
    var data = jsonDecode(response.body);

    productlists7.clear();
    data.forEach((element) =>
        productlists7.add(orginalteachermodel.fromJson(element)));
    data.forEach((element) =>
    teacherProfileModel = orginalteachermodel.fromJson(element));
    emit(Datadone());

    return productlists7.toSet();


  }catch(e){
    emit(feuleur());
  }

  }


}
