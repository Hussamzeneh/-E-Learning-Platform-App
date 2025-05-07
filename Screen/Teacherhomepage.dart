
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_instagram_storyboard/flutter_instagram_storyboard.dart';

import 'package:untitled4/Cubit/ADV%20cubit/neaadvcubit.dart';
import 'package:untitled4/Cubit/ADV%20cubit/neawadvstates.dart';
import 'package:untitled4/Custom_widget/Studenthomepage_widget/listofhomepagecard.dart';
import 'package:untitled4/Custom_widget/TeacherWidget/listofteacherhomepage.dart';
import 'package:untitled4/Model/models/advertisement_model.dart';
import 'package:untitled4/Model/neadvmodel.dart';
import 'package:untitled4/Screen/SubjectPage.dart';
import 'package:untitled4/Screen/TeacherList.dart';
import 'package:untitled4/constans.dart';


import '../../Custom_widget/instawidget/buildBorderDecoration.dart';
import '../../Custom_widget/instawidget/buildButtonChild.dart';
import '../../Custom_widget/instawidget/buildButtonDecoration.dart';
import '../../Custom_widget/instawidget/createDummyPage.dart';
import '../Custom_widget/genral/Master_Painter2.dart';
import '../Custom_widget/genral/main_title.dart';
import '../Custom_widget/genral/master_painter.dart';
import '../Custom_widget/genral/topclib.dart';

import '../../grades/grades_page.dart';

class TeacherHomePage extends StatelessWidget {
  const TeacherHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            top: 550,
            left: 50,
            child: CustomPaint(
              painter: MasterPainter(),
              child: SizedBox(),
            ),
          ),
          Positioned(
            top: 30,
            left: 250,
            child: CustomPaint(
              painter: MasterPainter2(),
              child: SizedBox(),
            ),
          ),
          Positioned(
            top: 160,
            left: 60,
            child: CustomPaint(
              painter: MasterPainter(),
              child: SizedBox(),
            ),
          ),
          Positioned(
            top: 290,
            left: 50,
            child: CustomPaint(
              painter: MasterPainter2(),
              child: SizedBox(),
            ),
          ),
          Positioned(
            top: 130,
            left: 250,
            child: CustomPaint(
              painter: MasterPainter2(),
              child: SizedBox(),
            ),
          ),
          Positioned(
            top: 260,
            left: 260,
            child: CustomPaint(
              painter: MasterPainter(),
              child: SizedBox(),
            ),
          ),
          Column(
            children: [
              Spacer(
                flex: 2,
              ),
              Container(
                child: listofteacherhomepagecard(),
              ),
              Spacer()
            ],
          )


        ],
      ),
    );
  }
}
