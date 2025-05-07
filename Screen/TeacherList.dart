import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/Cubit/Teacher%20cubit/TeacherCubit.dart';
import 'package:untitled4/Cubit/Teacher%20cubit/TeacherStates.dart';
import 'package:untitled4/Cubit/Teacher%20cubit/Teacherprofilecubit.dart';
import 'package:untitled4/Cubit/filterbarcubit/filterbarcubit.dart';
import 'package:untitled4/Custom_widget/genral/newpinkled.dart';
import 'package:untitled4/Custom_widget/genral/BlueLed.dart';
import 'package:untitled4/Custom_widget/genral/topclib.dart';
import 'package:untitled4/Custom_widget/scaleanimations.dart';
import 'package:untitled4/Screen/ProfileTeacher.dart';
import 'package:untitled4/constans.dart';
import '../Cubit/filterbarcubit/filterbarstate.dart';
import '../Custom_widget/TeacherWidget/TeacherCard.dart';
import '../Custom_widget/genral/FilterBarRow.dart';
import '../Custom_widget/genral/TopClipAppBar.dart';
import '../Model/TeacherProfileModel.dart';

class TeacherList extends StatelessWidget {
  orginalteachermodel? teacherProfileModel;

  TeacherList({super.key});
  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) =>filterbarcubit(),
      child: BlocProvider(
        create: (context) => TeacherCubit(),
        child: Scaffold(
            backgroundColor: KLPrimarycolor,
            appBar:  PreferredSize(
                preferredSize: Size.fromHeight(40),
                child: TopClipAppBar(
                  text1: 'T E A',
                  text2: ' C H',
                  text3: ' E R S',
                )),
            body: Stack(children: [
              topclib(
                  screensize: screensize,
                  Child2: Padding(
                    padding: const EdgeInsets.only(
                        left: 60.0, right: 60, bottom: 30, top: 35),
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Theme.of(context).colorScheme.outline,
                        ),
                        child: BlocBuilder<filterbarcubit, filterbarstates>(
                          builder: (context, state) {
                            return FilterBarRow();
                          },
                        )),
                  ),
                  Child:
                  Stack(children: [
                    const pinkled(550, 40),
                    const BlueLed(250, 200),
                    BlocBuilder<TeacherCubit, TeacherStates>(
                        builder: (context, state) {
                      Set<orginalteachermodel> teaclist =
                          BlocProvider.of<TeacherCubit>(context).productlists7;

                      if (state is Loading) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.pink,
                        ));
                      } else if (state is Datadone) {

                        return ScaleFadeAnimation(
                          delay: 2.5,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 80.0, left: 12, right: 12),
                            child: ListView.builder(
                                clipBehavior: Clip.hardEdge,
                                itemCount: teaclist.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        // BlocProvider(create: (context) => Teacherprofilecubit()..GetProfileTeacher(id: teaclist.toList()[index].id),) ;
                                        //
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) {
                                          return profileteacher(
                                            teacherdata: teaclist.toList()[index],
                                          );
                                        }));
                                      },
                                      child: TeacherCard(
                                        teacherProfileModel: teaclist.toList()[index],
                                      ));
                                }),
                          ),
                        );
                      } else {
                        return const Text('Failed to fetch teacher of this class');
                      }
                    })
                  ]))
            ])),
      ),
    );
  }
}
