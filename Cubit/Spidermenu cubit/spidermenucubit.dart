import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled4/Cubit/Spidermenu%20cubit/spidermenustates.dart';


import 'package:untitled4/Screen/ChatHomePage.dart';
import 'package:untitled4/Screen/setting.dart';

class spidermenucubit extends Cubit<spidermenustates>{
  spidermenucubit() : super(home()) ;









  body ({required int index}){
    if(index == 0){
      emit(home());



    }else if (index == 1) {

      emit(chat());


    }else if (index == 3){
      emit(profile());



    }else if (index == 4){
      emit(favourite());



    }

    else {
      emit(setting1());

    }







  }





}