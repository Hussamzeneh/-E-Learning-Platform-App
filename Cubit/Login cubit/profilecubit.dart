import 'dart:convert';
import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/Cubit/Login%20cubit/profilestates.dart';
import 'package:untitled4/Cubit/Theme%20cubit/themecubit.dart';
import 'package:untitled4/Model/TeacherProfileModel.dart';
import 'package:untitled4/Screen/LoginPage.dart';
import 'package:untitled4/Screen/pofile.dart';
import '../../Model/StudentProfileModel.dart';
import 'package:http/http.dart' as http;
import '../../constans.dart';
import '../auth.dart';

String? fingerprintcode;
String? fingerprintpassword;
String? firebasetoken1;

class Profilecubit extends Cubit<ProfileStates> {
  Profilecubit() : super(initialstates());

  StudentProfileModel? studentdata;
  orginalteachermodel? teacherprofilemodel;

  Future<Object?> loginmethod(
      {required code, required password, BuildContext? context}) async {
    emit(loading());
    http.Response response = await http.post(
        Uri.parse('http://$KURL:8000/api/login'),
        headers: {HttpHeaders.acceptHeader: 'application/json'},
        body: {'code': code, 'password': password, 'remember': 'true'});
    fingerprintcode = code;
    fingerprintpassword = password;
    Map<String, dynamic> data = jsonDecode(response.body);

    try {
      studentdata = StudentProfileModel.fromJson(data['data']);
      firebasetoken1 = data['token'];

      registerUser(
              studentdata!.email,
              password!,
              studentdata!.profilepicturepath,
              studentdata!.firstname,
              studentdata!.Lastname,
              studentdata!.classlevel,
              studentdata!.role)
          .then((userCredential) {})
          .catchError((error) {
        if (kDebugMode) {
          print('Failed to register user: $error');
        }
      });
      signInUser(
          studentdata!.email,
          password!,
          studentdata!.profilepicturepath,
          studentdata!.firstname,
          studentdata!.Lastname,
          studentdata!.classlevel,
          studentdata!.role);
      emit(datasucces());
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          clipBehavior: Clip.none,
          duration: const Duration(seconds: 4),
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            titleFontSize: 20,
            color:
                context.read<ThemeCubit>().state.brightness == Brightness.dark
                    ? Color(0xffffe91e63)
                    : Colors.green,
            title: 'Sucees',
            message: '${data['message']}',
            contentType: ContentType.success,
            inMaterialBanner: true,
          )));

      if (data['data']['role'] == 'student') {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return profile2(
              userdata: studentdata,
            );
          }));
        });
      } else if (data['data']['role'] == 'teacher') {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return profile2(
              userdata: studentdata,
            );
          }));
        });
      }
emit(initialstates());
      return studentdata;
    } catch (e) {
      emit(feulieur());
      ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          clipBehavior: Clip.none,
          elevation: 0,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            titleFontSize: 20,
            color:
                context.read<ThemeCubit>().state.brightness == Brightness.dark
                    ? Colors.red
                    : Colors.pink,

            title: 'FAILED',
            message: '${data['message']}',
            contentType: ContentType.failure,
            inMaterialBanner: true,
          )));
    }
    emit(initialstates());
    return null;
  }

  Logout({required BuildContext context}){
    emit(initialstates());
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return LoginPage();

    }));

  }
}
