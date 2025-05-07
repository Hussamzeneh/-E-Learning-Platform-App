import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:untitled4/Cubit/Login%20cubit/login_states.dart';
import 'package:untitled4/Functions/finger_print.dart';
import 'package:untitled4/constans.dart';
import 'package:untitled4/forgot_password&resset_password%20&%20verify_code/verify_code/cubit/code_states.dart';
import '../../Screen/testfinger.dart';

class logincubit extends Cubit<loginstates>{
  logincubit() : super(intialcodestate()) ;


  Color ? color1 =  Color(0xffFF08083A) ;
  Color ? color2 =  Color(0xffFF08083A);
  Color ? color3 =  Color(0xffFF08083A);
  Color ? color4 =  Color(0xffFF08083A);
  Color ? color5 =  Color(0xffFF08083A) ;
  Color ? color6 =  Color(0xffFF08083A) ;
  bool obsecure = true;






getcolorbox2( BuildContext context,String num){
  if(num == ''){
    color6 =  KLSecondarycolor;
    emit(codestateoff());

  }else{
    color6 =  Colors.pink;
    emit(codestateon());

  }





}
resetboxcolor(){
  emit(intialcodestate());
}





   getcolorbox1 ( BuildContext context ,String num, int index1 ){

    if (num == ''){
if(index1 ==0 ){
  color1 =  KLSecondarycolor;


  emit(codestateoff());


}else if(index1 == 1){
  color2 =  KLSecondarycolor;
  emit(codestateoff());


}else if(index1 == 2){
  color3 =  KLSecondarycolor;
  emit(codestateoff());


}else if(index1 == 3){
  color4 =  KLSecondarycolor;
  emit(codestateoff());


}else if(index1 == 4){
  color5 =  KLSecondarycolor;
  emit(codestateoff());


}




    }else {
      if(index1 == 0){

        color1 = Colors.pink;



        emit(codestateon());


      }else if(index1 == 1){

        color2 = Colors.pink;


        emit(codestateon());
      }else if(index1 == 2){
        color3 = Colors.pink;


        emit(codestateon());
      }else if(index1 == 3){

        color4 = Colors.pink;


        emit(codestateon());
      }else if(index1 == 4){

        color5 = Colors.pink;


        emit(codestateon());
      }




    }

    }




  bool toggelepassword(bool obsecure1){
  obsecure =! obsecure1 ;
  if(obsecure){
    emit(passowrdvisee());
    return obsecure ;

  }else {
    emit(passworddontvisee());
    return obsecure ;
  }
  }








}


















