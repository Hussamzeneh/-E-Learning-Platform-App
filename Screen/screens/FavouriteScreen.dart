import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/Cubit/FavouriteCubit/FavouriteCubit.dart';
import 'package:untitled4/Cubit/FavouriteCubit/FavouriteStates.dart';
import 'package:untitled4/Model/Librarybookmodel.dart';

import '../Cubit/filterbarcubit/filterbarcubit.dart';
import '../Cubit/filterbarcubit/filterbarstate.dart';
import '../Custom_widget/Favouritewidget/favouritefilterbar.dart';
import '../Custom_widget/LibraryWidget/BookCard.dart';
import '../Custom_widget/TeacherWidget/TeacherCard.dart';
import '../Custom_widget/genral/BlueLed.dart';
import '../Custom_widget/genral/TopClipAppBar.dart';
import '../Custom_widget/genral/newpinkled.dart';
import '../Custom_widget/genral/topclib.dart';
import '../Model/TeacherProfileModel.dart';

class favouritescreen extends StatelessWidget {
  const favouritescreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return BlocProvider(
      create: (context) => FavouriteCubit(),
      child: BlocProvider(
        create: (context)=> filterbarcubit(),
        child: Scaffold(
          appBar: const PreferredSize(
              preferredSize: Size.fromHeight(40),
              child: TopClipAppBar(
                isleading: false,
                text1: 'F A',
                text2: ' V O U R',
                text3: ' I T E',
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
                            return  favouritefilterbar();
                          },
                        )),
                  ),
                  Child: Stack(children: [
                    const pinkled(550, 40),
                    const BlueLed(250, 200),
                    BlocBuilder<FavouriteCubit, FavouriteStates>(
                        builder: (context, state) {
                      print(state);
                      Set<LibraryModel> booklist =
                          BlocProvider.of<FavouriteCubit>(context).favbooklist;
                      if (state is Loadingfavbook) {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.pink,
                        ));
                      } else if (state is Sucsesfavbook) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(top: 80.0, left: 12, right: 12),
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                              ),
                              clipBehavior: Clip.hardEdge,
                              itemCount: booklist.length,
                              itemBuilder: (context, index) {
                                return BookCard(
                                  libraryBookModel: booklist.toList()[index],
                                );
                              }),
                        );
                      } else if (state is Sucsesfavteacher) {
                        Set<orginalteachermodel> teaclist =
                            BlocProvider.of<FavouriteCubit>(context).productlists7;

                        return Padding(
                          padding:
                              const EdgeInsets.only(top: 80.0, left: 12, right: 12),
                          child: ListView.builder(
                              clipBehavior: Clip.hardEdge,
                              itemCount: teaclist.length,
                              itemBuilder: (context, index) {
                                return TeacherCard(
                                  teacherProfileModel: teaclist.toList()[index],
                                );
                              }),
                        );
                      } else if (state is feuliurfavbook) {
                        return const Center(
                            child: Text('There is no Favourite item '));
                      } else {
                        return const SizedBox();
                      }
                    })
                  ])),
            ],
          ),
        ),
      ),
    );
  }
}
