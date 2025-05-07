import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/Cubit/Library/LibraryCubit.dart';
import 'package:untitled4/Cubit/Library/LibraryStates.dart';
import 'package:untitled4/Custom_widget/LibraryWidget/libraryfilterbar.dart';
import 'package:untitled4/Custom_widget/animations.dart';
import 'package:untitled4/Custom_widget/genral/topclib.dart';
import 'package:untitled4/Custom_widget/scaleanimations.dart';
import 'package:untitled4/Model/Librarybookmodel.dart';
import '../Cubit/filterbarcubit/filterbarcubit.dart';
import '../Cubit/filterbarcubit/filterbarstate.dart';
import '../Custom_widget/LibraryWidget/BookCard.dart';
import '../Custom_widget/genral/BlueLed.dart';
import '../Custom_widget/genral/TopClipAppBar.dart';
import '../Custom_widget/genral/newpinkled.dart';


class Librarypage extends StatelessWidget {
  const Librarypage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size ;
    return

      BlocProvider(
        create: (context) => filterbarcubit(),
        child: BlocProvider(
          create: (context) => LibraryCubit(),
          child: Scaffold(
          appBar:   PreferredSize(
              preferredSize: Size.fromHeight(40),
              child: TopClipAppBar(
                text1: 'L I',
                text2: ' B R A',
                text3: ' R Y',
              )),
          body: Stack(
            children: [
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
                          return libraryfilterbar();
                        },
                      )),
                ),
                Child:

                Stack(children: [
                  const pinkled(550, 40),
                  const BlueLed(250, 200),
                  BlocBuilder<LibraryCubit, Librarystates>(
                      builder: (context, state) {
                        Set<LibraryModel> booklist =
                            BlocProvider.of<LibraryCubit>(context).booklists;

                        if (state is  loadinglibrary) {
                          return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.pink,
                              ));
                        } else if (state is successlibrary) {
                          return Padding(
                            padding:
                            const EdgeInsets.only(top: 80.0, left: 12, right: 12),
                            child: GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2 ,


                              ),

                                clipBehavior: Clip.hardEdge,
                                itemCount: booklist.length,
                                itemBuilder: (context, index) {
                                  return ScaleFadeAnimation (
                                    delay: 2.5,
                                    child: BookCard(
                                      libraryBookModel: booklist.toList()[index],
                                    ),
                                  );
                                }),
                          );
                        } else {
                          return const Center(child: const Text('Failed to fetch book'));
                        }
                      })
                ])



              ),
            ],
          ),






              ),
        ),
      );
  }
}
