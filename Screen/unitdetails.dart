import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled4/Custom_widget/topprofileunit.dart';
import 'package:untitled4/Model/unitmodel.dart';
import '../Custom_widget/genral/newpinkled.dart';
import '../Custom_widget/genral/BlueLed.dart';
class unitdetails extends StatelessWidget {
  unitdetails({required this.model, super.key});
  unitmodel? model;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Welcome to Unit :  ${model!.unitnumber.toString()}'),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          const pinkled(550, 20),
          const BlueLed(30, 255),
          ListView(
            children: [
              topprofilesunit(Userdata: model),
              Padding(
                padding: EdgeInsets.only(top: 46.0.h, left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [const Text('Title : '), Text(model!.title)],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [const Text('About : '), Text(model!.descrebtion)],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
