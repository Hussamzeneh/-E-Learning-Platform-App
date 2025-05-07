// import 'dart:convert';
//
// import 'package:bloc/bloc.dart';
// import 'package:untitled4/Cubit/Teacher%20cubit/TeacherProfileStates.dart';
// import 'package:http/http.dart' as http;
// import 'package:untitled4/Model/TeacherProfileModel.dart';
//
// import '../../constans.dart';
//
// class Teacherprofilecubit extends Cubit<Teacherprofilestates>{
//   Teacherprofilecubit() : super(initialstate());
//
// orginalteachermodel ?Teacherprofilemodel ;
//
// GetProfileTeacher({required int id})async{
//
//
//   http.Response response = await http.get(
//       Uri.parse('http://${KURL}:8000/api/profileteacher/$id')) ;
//
//   Map <String , dynamic> data = jsonDecode(response.body) ;
//   Teacherprofilemodel = orginalteachermodel.fromJson(data['data']);
//   print(Teacherprofilemodel) ;
//
//
//
//
//
// }
//
//
//
// }