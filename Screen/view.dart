import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/Custom_widget/Studenthomepage_widget/listofhomepagecard.dart';
import 'package:untitled4/Custom_widget/animations.dart';
import 'package:untitled4/Custom_widget/genral/newpinkled.dart';
import 'package:untitled4/Custom_widget/genral/BlueLed.dart';
import 'package:untitled4/Custom_widget/scaleanimations.dart';
import '../../Cubit/ADV cubit/neaadvcubit.dart';
import '../../Cubit/ADV cubit/neawadvstates.dart';
import '../../Custom_widget/Studenthomepage_widget/buildstorylistview.dart';

class StudentHomePage extends StatelessWidget {
  const StudentHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => newadvcubit(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            const pinkled(550, 50),
            const BlueLed(30, 250),
            const pinkled(160, 60),
            const BlueLed(290, 50),
            const BlueLed(130, 250),
            const pinkled(260, 260),
            Column(
              children: [
                BlocBuilder<newadvcubit, newadvstates>(
                  builder: (context, state) {
                    if (state is advloading) {
                      return const CircularProgressIndicator();
                    } else if (state is advfeuliur) {
                      return const Center(child: Text('erooooooooooooor'));
                    }
                    List bus = BlocProvider.of<newadvcubit>(context).buses;
                    List exam = BlocProvider.of<newadvcubit>(context).exams;
                    List journy = BlocProvider.of<newadvcubit>(context).journy;
                    List student = BlocProvider.of<newadvcubit>(context).student;
                    List wallet = BlocProvider.of<newadvcubit>(context).wallet;
                    List instroctions =
                        BlocProvider.of<newadvcubit>(context).instructions;

                    return ScaleFadeAnimation(
                      delay: 3,
                      child: Padding(
                        padding: EdgeInsets.only(top: screensize.height * .1),
                        child: SizedBox(
                          height: screensize.height * .2,
                          child: buildStoryListView(
                              bus, exam, student, journy, instroctions, wallet),
                        ),
                      ),
                    );
                  },
                ),
                ScaleFadeAnimation(
                  delay: 2.5 ,
                  child: SizedBox(
                      height: screensize.height * .7, child: listofjomepagecard()),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
