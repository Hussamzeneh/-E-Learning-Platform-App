
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttermoji/fluttermojiCircleAvatar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rive/rive.dart';
import 'package:untitled4/Cubit/Login%20cubit/fingerprintcubit.dart';

import 'package:untitled4/Cubit/Spidermenu%20cubit/spidermenucubit.dart';
import 'package:untitled4/Cubit/Spidermenu%20cubit/spidermenustates.dart';

import 'package:untitled4/Model/StudentProfileModel.dart';
import 'package:untitled4/Screen/ChatHomePage.dart';
import 'package:untitled4/Screen/FavouriteScreen.dart';
import 'package:untitled4/Screen/LoginPage.dart';
import 'package:untitled4/Screen/Profile.dart';
import 'package:untitled4/Screen/Teacherhomepage.dart';

import 'package:untitled4/Screen/setting.dart';
import 'package:untitled4/Screen/student_home_page/view.dart';


import '../Custom_widget/spidermenu_widget/Riveasset.dart';
import '../Custom_widget/fluttermoje_widget/fluttermojeedit.dart';
import '../Custom_widget/spidermenu_widget/menubutton.dart';

import '../Custom_widget/spidermenu_widget/spidermenu.dart';
import '../Functions/finger_print.dart';
import '../constans.dart';



class profile2 extends StatefulWidget {
  StudentProfileModel ?userdata ;
   profile2({required this.userdata});

  @override
  State<profile2> createState() => _profile2State() ;
}

class _profile2State extends State<profile2>  with SingleTickerProviderStateMixin {
  @override
  VoidCallback ? press ;
  ValueChanged<Artboard>? riveOnInit;
  late SMIBool ismenuclosed;
  bool issidemenuclosed= true ;
  late AnimationController _animationController;
  late Animation<double> animation ;
  late Animation<double> scalanimation ;

  @override
  void initState() {
    _animationController =AnimationController(vsync: this , duration: Duration(milliseconds:  200) ,)..addListener(() {setState(() {

    });});
    super.initState();


    animation = Tween<double>(begin: 0 , end: 1).animate(CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn));
    scalanimation = Tween<double>(begin: 1 , end: 0.8).animate(CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn));
  }
  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  Widget build(BuildContext context) {


    return BlocProvider(
      create: (context) => spidermenucubit(),
      child: Scaffold(
          backgroundColor:  Theme.of(context).colorScheme.tertiaryContainer,
          extendBody:  true,

          resizeToAvoidBottomInset: false,

          body: Stack(
            children: [



              AnimatedPositioned(
                  duration: Duration(milliseconds: 200),
                  curve: Curves.fastOutSlowIn,
                  width:  288,
                  height: MediaQuery.of(context).size.height,
                  left:  issidemenuclosed?- 288:0,

                  child: spidermenu()),

              Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..setEntry(3, 2, 0.001)..rotateY(animation.value-30*animation.value*pi /180),
                child: Transform.translate(
                    offset: Offset(animation.value * 265 , 0),

                    child: Transform.scale(
                        scale: scalanimation.value,
                        child: ClipRRect(


                            borderRadius: issidemenuclosed?BorderRadius.zero:BorderRadius.all(Radius.circular(30)),
                            child: BlocBuilder<spidermenucubit , spidermenustates>(builder: (context , state){

                              if (state is home){
                                if(widget.userdata!.role == 'student'){
                                  return StudentHomePage();

                                }else{
                                  return TeacherHomePage();

                                }



                              }else if (state is chat){
                                return ChatHomePage();



                              }else if (state is profile) {
                                return Profile();


                              }else if (state is favourite) {
                                return const favouritescreen();


                              }
                              else {
                                return BlocProvider(
                                    create: (context) => fingerprintcubit(),
                                    child: setting());

                              }






                            },)))),
              ) ,

              AnimatedPositioned(
                curve: Curves.fastOutSlowIn,
                duration: Duration(milliseconds:  200),
                top: 20.h,
                left:  issidemenuclosed ?10.w:220.w,
                child: menubutton( riveOnInit: (artboard){
                  StateMachineController controller = RiveUtils.getRivecontroller(artboard , StateMachineName: 'State Machine');
                  ismenuclosed = controller.findSMI('isOpen')as SMIBool ;
                  ismenuclosed.value = true;

                } , press:  (){
                  ismenuclosed.value = !ismenuclosed.value;
                  if(issidemenuclosed){
                    _animationController.forward();
                  }else{
                    _animationController.reverse();
                  }
                  setState(() {
                    issidemenuclosed = ismenuclosed.value;
                  });
                },),
              )
            ],
          ),
        ),
    );

  }



}

