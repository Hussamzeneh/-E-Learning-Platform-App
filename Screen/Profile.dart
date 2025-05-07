import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled4/Cubit/Login%20cubit/profilecubit.dart';
import 'package:untitled4/Cubit/Login%20cubit/profilestates.dart';
import 'package:untitled4/Custom_widget/genral/newpinkled.dart';
import 'package:untitled4/Custom_widget/genral/BlueLed.dart';
import '../Custom_widget/Profile/topprofile.dart';
import '../Custom_widget/ProfileWidget/ProfileDataListtile.dart';
import '../Model/StudentProfileModel.dart';

class Profile extends StatelessWidget {
  @override
  StudentProfileModel? Userdata;
  final double coverHiegh = 280;
  final double ProfileHight = 140;
  @override
  Widget build(BuildContext context) {
    final top1 = coverHiegh - ProfileHight / 2 - 10;
    return BlocProvider(
      create: (context) => Profilecubit()..loginmethod(code: fingerprintcode, password: fingerprintpassword),
      child: BlocBuilder<Profilecubit, ProfileStates>(builder: (context, state) {
        Userdata = BlocProvider.of<Profilecubit>(context).studentdata!;
        return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: Stack(
              children: [
                const pinkled(740, 50),
                const BlueLed(300, 250),
                ListView(
                  children: [
                    topprofile(top: top1, Userdata: Userdata),
                    Column(
                      children: [
                        Padding(
                            padding:  EdgeInsets.only(
                                top: 80.h),
                            child: SizedBox(
                              height: 400,
                              child: ListView.builder(

                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: 5,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(

                                        height: 60,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .tertiaryFixed
                                                  .withOpacity(.1)),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primaryContainer,
                                        ),
                                        child: ProfileDataListtile(
                                          Userdata: Userdata,
                                          index: index,
                                          context: context,
                                        ),
                                      ),
                                    );
                                  }),
                            )),
                      ],
                    ),
                  ],
                ),
              ],
            ));
      }),
    );
  }
}
