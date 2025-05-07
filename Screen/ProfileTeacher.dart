import 'package:flutter/material.dart';

import 'package:untitled4/Custom_widget/TeacherWidget/topprofileteacher.dart';
import 'package:untitled4/Custom_widget/genral/newpinkled.dart';
import 'package:untitled4/Custom_widget/genral/BlueLed.dart';
import 'package:untitled4/Screen/pdf.dart';

import '../Model/TeacherProfileModel.dart';
import '../constans.dart';

class profileteacher extends StatelessWidget {
  const profileteacher({super.key, required this.teacherdata});

  final orginalteachermodel? teacherdata;

  @override
  Widget build(BuildContext context) {
    const double coverHiegh = 280;
    const double ProfileHight = 140;
    final List<Icon> listtileicon = [
      const Icon(Icons.file_copy),
      const Icon(Icons.email),
      const Icon(Icons.phone),
      const Icon(Icons.cake_rounded),
      const Icon(Icons.transgender_rounded),
      const Icon(Icons.perm_contact_cal)
    ];
    final List<void Function()> ontaplist = [
      () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return PDFViewerFromUrl(
            url: 'http://$KURL:8000${teacherdata!.cv}',
            title: 'Teacher cv',
          );
        }));
      },
      () {},
      () {},
      () {},
      () {},
      () {}
    ];
    const top1 = coverHiegh - ProfileHight / 2 - 10;

      List<String> listtiledata = [
        'Teacher Cv',
        teacherdata!.email,
        teacherdata!.phone,
        teacherdata!.Birthdate,
        teacherdata!.gender,
        teacherdata!.role
      ];
      return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          body: Stack(
            children: [
              const pinkled(750, 40),
              const BlueLed(300, 250),
              ListView(
                children: [
                  topprofileteacher(top: top1, Userdata: teacherdata),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 80.0),
                        child: SizedBox(
                          height: 500,
                          child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: listtiledata.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: GestureDetector(
                                    onTap: ontaplist[index],
                                    child: Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: KLSecondarycolor.withOpacity(
                                                .1)),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primaryContainer,
                                      ),
                                      child: ListTile(
                                          title: Text(
                                            listtiledata[index],
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .tertiaryFixed,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          leading: listtileicon[index]),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ));

  }
}
