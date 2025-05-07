import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:untitled4/Cubit/Login%20cubit/profilecubit.dart';

import 'package:untitled4/Functions/finger_print.dart';

import '../../Model/StudentProfileModel.dart';
import 'fingerprintstate.dart';

class fingerprintcubit extends Cubit<fingerprintstates> {
  fingerprintcubit() : super(initialstate()) {
    checkiffingerprintenabeled();
    loaduser();
  }
  String? codefinger;
  String? passfinger;
  StudentProfileModel? Userdata;

//call the library and make instance
  fingerprint _fingerprint = fingerprint();
  FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true));
  String fprint = '';
  bool switchvalue = false;

// this method refresh te ui
  void loaduser() async {
    fprint = await _flutterSecureStorage.read(key: "fingerprint") ?? '';
    codefinger = await _flutterSecureStorage.read(key: "codefinger") ?? '';
    passfinger = await _flutterSecureStorage.read(key: 'passfinger') ?? '';
    switchvalue = fprint.isNotEmpty;
  }

// this method handele the ui (on - off)
  void switchonfingerprint(BuildContext context, value, mounted) async {
    if (value) {
      bool isfingerprintenable = await _fingerprint.isfingerprintenabeled();
      if (isfingerprintenable) {
        print('fingerprint is enabeled');
        await _flutterSecureStorage.write(key: "fingerprint", value: "checked");
        await _flutterSecureStorage.write(key: "codefinger", value: "${fingerprintcode}");
        await _flutterSecureStorage.write(key: "passfinger", value: fingerprintpassword);
        codefinger = fingerprintcode;
        passfinger = fingerprintpassword;
        print(fprint);
        print(fingerprintcode);
        print(codefinger);
        print(passfinger);

        emit(fingerprintisenabeled());
      }
    } else {
      print('sssssssssssssssssssssssssssss');
      print(value);
      await _flutterSecureStorage.delete(key: "fingerprint");
      emit(fingerprintisnotenabeled());
    }

    switchvalue = value;
  }

  // this method handele the login progress
  void fingerprintlogin(BuildContext context) async {
    bool _fingerprintenabeled = await _fingerprint.isfingerprintenabeled();

    if (_fingerprintenabeled) {
      bool isauth = await _fingerprint.isauth('login with finger print ');

      if (isauth) {
        print('authhh');


        BlocProvider.of<Profilecubit>(context).loginmethod(
            code: codefinger, password: passfinger, context: context);
        print(codefinger);

        emit(fprintauthdone());
      } else {
        emit(fprintauthfeulier());
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('your device dont supported finger print')));
    }
  }

  //this method check if the platform is supported the finger print sensor

  void checkiffingerprintenabeled() async {
    fprint = await _flutterSecureStorage.read(key: 'fingerprint') ?? '';
    if (fprint.isNotEmpty) {
      print(fprint);
      emit(fingerprintisenabeled());
    } else {
      emit(fingerprintisnotenabeled());
      print(fprint);
    }
  }
}
