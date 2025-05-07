import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/Cubit/Subject%20cubit/subjectcubit.dart';
import 'package:untitled4/Cubit/Subject%20cubit/subjectdetailscubit.dart';
import 'package:untitled4/Cubit/Subject%20cubit/subjectstates.dart';
import 'package:untitled4/Cubit/filterbarcubit/filterbarcubit.dart';
import 'package:untitled4/Custom_widget/genral/newpinkled.dart';
import 'package:untitled4/Custom_widget/genral/FilterBarRowSubjects.dart';
import 'package:untitled4/Custom_widget/genral/BlueLed.dart';
import 'package:untitled4/Custom_widget/genral/TopClipAppBar.dart';
import 'package:untitled4/Custom_widget/subject_widget/subjectcard.dart';
import 'package:untitled4/Custom_widget/genral/topclib.dart';
import 'package:untitled4/Model/subjectmodel.dart';
import 'package:untitled4/Screen/subjectdetails.dart';
import '../Cubit/filterbarcubit/filterbarstate.dart';
class SubjectPage extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => filterbarcubit(),
      child: BlocProvider(
        create: (context) => subjectcubit(),
        child: Scaffold(
          appBar: const  PreferredSize(
              preferredSize: Size.fromHeight(50),
              child: TopClipAppBar(
                text1: 'S U',
                text2: ' B J E C',
                text3: ' T S',
              )),
          body: topclib(
            screensize: screensize,
            Child2: Padding(
              padding:
                  const EdgeInsets.only(left: 60.0, right: 60, bottom: 30, top: 35),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  child: BlocBuilder<filterbarcubit, filterbarstates>(
                    builder: (context, state) {
                      return  FilterBarRowSubjects();
                    },
                  )),
            ),
            Child: Stack(
              children: [
                const BlueLed(150, 100),
                const pinkled(150, 300),
                const pinkled(350, 100),
                const BlueLed(350, 300),
                Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: BlocBuilder<subjectcubit, subjectstate>(
                      builder: (context, state) {
                        Set<Subjectmodel> sublist =
                            BlocProvider.of<subjectcubit>(context).subjectlists7;
                        if (state is subjectsucces) {
                          return ListView.builder(
                              itemCount: sublist.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {

                                        return BlocProvider(
                                          create: (context) => subjectdetailscubit()..getsubjectdetails(id: sublist.toList()[index].id),
                                          child: subjectdetails(
                                              model: sublist.toList()[index]),
                                        );
                                      }));
                                    },
                                    child: subjectcard(
                                        subjectmodel: sublist.toList()[index]));
                              });
                        } else if (state is subjectloading) {
                          return const Center(
                              child: CircularProgressIndicator(
                            color: Colors.pink,
                          ));
                        } else {
                          return const Center(child: Text('no internet'));
                        }
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
