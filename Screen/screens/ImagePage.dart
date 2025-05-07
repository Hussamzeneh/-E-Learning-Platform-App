import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled4/Cubit/profile%20cubit/profileimagecubit.dart';
import 'package:untitled4/Cubit/profile%20cubit/profileimagestate.dart';
import 'package:untitled4/Model/StudentProfileModel.dart';
import 'package:untitled4/Screen/AvatarPage.dart';
import 'package:untitled4/constans.dart';

bool Deletephoto = false;

class ImagePage extends StatelessWidget {
  ImagePage({super.key, this.userdata});
  StudentProfileModel? userdata;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileImageCubit(),
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              backgroundColor: Theme.of(context).colorScheme.surface,
              bottomNavigationBar: Container(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  height: 60),
              appBar: AppBar(
                actions: [
                  Center(
                      child: GestureDetector(
                          onTap: () {
                            Get.bottomSheet(Container(
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                              height: 350,
                              width: double.infinity,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(24.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(40)),
                                            height: 50,
                                            width: 50,
                                            child: FittedBox(
                                                fit: BoxFit.cover,
                                                child: handelesmallimagebloc())),
                                        const Text(
                                          'Edit Profile Image',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        GestureDetector(
                                            onTap: () {
                                              Get.back();
                                            },
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 25,
                                            ))
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Container(
                                        height: 220,
                                        decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface,
                                            borderRadius: const BorderRadius.all(
                                                Radius.circular(16))),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                    return const AvatarPage();
                                                  }));
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Use Avatar',
                                                      style: TextStyle(
                                                          color: Theme.of(context)
                                                              .colorScheme
                                                              .tertiaryFixed,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Icon(
                                                      Icons.face,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .tertiaryFixed,
                                                      size: 25,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Divider(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiaryFixed,
                                                thickness: .8,
                                                endIndent: 30,
                                                indent: 30),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  BlocProvider.of<
                                                              ProfileImageCubit>(
                                                          context)
                                                      .Uploadimage();
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Take Photo',
                                                      style: TextStyle(
                                                          color: Theme.of(context)
                                                              .colorScheme
                                                              .tertiaryFixed,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Icon(
                                                      Icons.camera_alt_rounded,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .tertiaryFixed,
                                                      size: 25,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Divider(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiaryFixed,
                                                thickness: .8,
                                                endIndent: 30,
                                                indent: 30),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  BlocProvider.of<
                                                              ProfileImageCubit>(
                                                          context)
                                                      .Uploadimage2();
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'Select Photo',
                                                      style: TextStyle(
                                                          color: Theme.of(context)
                                                              .colorScheme
                                                              .tertiaryFixed,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Icon(
                                                      Icons.image,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .tertiaryFixed,
                                                      size: 25,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  )
                                ],
                              ),
                            ));
                          },
                          child: const Text(
                            'EDIT',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ))),
                ],
                leading: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                title: const Text(
                  'Personal Profile Image',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                centerTitle: true,
              ),
              body: handeleimagebloc())),
    );
  }

  BlocBuilder<ProfileImageCubit, profileimagestate> handeleimagebloc() {
    return BlocBuilder<ProfileImageCubit, profileimagestate>(
        builder: (context, state) {
      print(state);
      if (state is initialstate) {
        return Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 3,
              child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: FittedBox(
                      fit: BoxFit.cover,
                      child: Image.network(
                          'http://$KURL:8000${userdata!.profilepicturepath}'))),
            ),
            const Spacer(
              flex: 1,
            )
          ],
        );
      } else if (state is fromgallery) {
        return Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 3,
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Image.file(state.imagegallery!)),
              ),
            ),
            const Spacer(
              flex: 1,
            )
          ],
        );
      } else if (state is Pickedimage) {
        return Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 3,
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: FittedBox(
                    fit: BoxFit.cover, child: Image.file(state.image)),
              ),
            ),
            const Spacer(
              flex: 1,
            )
          ],
        );
      } else if (state is avatar1) {
        return Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: KLPrimarycolor,
                        boxShadow: [
                          BoxShadow(
                              color: KLSecondarycolor.withOpacity(.25),
                              offset: const Offset(0, 4),
                              blurRadius: 20,
                              spreadRadius: 0)
                        ]),
                    child: FluttermojiCircleAvatar(
                      radius: 100,
                      backgroundColor: KLPrimarycolor,
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            )
          ],
        );
      } else if (state is deleteimage) {
        return Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 3,
              child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.network(
                      'http://$KURL:8000${userdata!.profilepicturepath}')),
            ),
            const Spacer(
              flex: 1,
            )
          ],
        );
      } else {
        return Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 3,
              child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.network(
                      'http://$KURL:8000${userdata!.profilepicturepath}')),
            ),
            const Spacer(
              flex: 1,
            )
          ],
        );
      }
    });
  }

  BlocBuilder<ProfileImageCubit, profileimagestate> handelesmallimagebloc() {
    return BlocBuilder<ProfileImageCubit, profileimagestate>(
        builder: (context, state) {
      print(state);
      if (state is initialstate) {
        return Image.network(
            'http://$KURL:8000${userdata!.profilepicturepath}');
      } else if (state is Pickedimage) {
        return Image.file(state.image);
      } else if (state is avatar1) {
        return FluttermojiCircleAvatar(
          backgroundColor: KLSecondarycolor,
        );
      } else if (state is fromgallery) {
        return Image.file(state.imagegallery!);
      } else if (state is deleteimage) {
        return Image.asset('lib/images/deleteimage.jpg');
      } else {
        return Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            Expanded(
              flex: 3,
              child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: Image.network(
                      'http://$KURL:8000${userdata!.profilepicturepath}')),
            ),
            const Spacer(
              flex: 1,
            )
          ],
        );
      }
    });
  }
}
