import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:untitled4/Custom_widget/Setting_widget/settingcard.dart';
import 'package:untitled4/Custom_widget/genral/topclib.dart';
import 'package:untitled4/Model/settingcardmodel.dart';

import 'package:untitled4/constans.dart';

import '../Cubit/Login cubit/fingerprintcubit.dart';

import '../Cubit/Login cubit/fingerprintstate.dart';
import '../Cubit/Theme cubit/themecubit.dart';
import '../Custom_widget/genral/Master_Painter2.dart';
import '../Custom_widget/genral/master_painter.dart';

class setting extends StatefulWidget {
  const setting({super.key});

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
  String fprint = '';
  bool switchvalue1 = false;
  bool switchvalue2 = false;
  bool switchvalue3 = false;
  settingcardmodel? Settingcardmodel1;

  List<settingcardmodel> Settingcardmodellist = [
    settingcardmodel(
        Image: 'lib/images/icons8-touch-id-100.png',
        title: 'FINGER PRINT',
        subtitle: 'lets make your login easy',
        switch1: false),
    settingcardmodel(
        Image: 'lib/images/night-mode.png',
        title: 'dark mode',
        subtitle: 'lets change the themess!',
        switch1: false),
    settingcardmodel(
        Image: 'lib/images/language.png',
        title: 'LANGUAGES',
        subtitle: 'lets discover new language man !',
        switch1: false),
    settingcardmodel(
        Image: 'lib/images/icons8-notification-96.png',
        title: 'NOTTIFICATIONS',
        subtitle: 'lets be more attention',
        switch1: false),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<fingerprintcubit, fingerprintstates>(
        listener: (context, state) {
      if (state is fingerprintisenabeled) {
        fprint = BlocProvider.of<fingerprintcubit>(context).fprint;
        switchvalue1 = BlocProvider.of<fingerprintcubit>(context).switchvalue;
      } else if (state is fingerprintisnotenabeled) {
        fprint = BlocProvider.of<fingerprintcubit>(context).fprint;
        Settingcardmodel1?.switch1 =
            BlocProvider.of<fingerprintcubit>(context).switchvalue;
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: KLPrimarycolor,
        resizeToAvoidBottomInset: false,
        body: topclib(
            Child2: Center(
              child: RichText(
                text: const TextSpan(
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(text: 'S E '),
                      TextSpan(
                          text: ' T T ',
                          style: TextStyle(color: Colors.pinkAccent)),
                      TextSpan(text: ' I N G S ')
                    ]),
              ),
            ),
            screensize: size,
            Child: Stack(
              children: [
                Positioned(
                  top: 550,
                  left: 20,
                  child: CustomPaint(
                    painter: MasterPainter(),
                    child: const SizedBox(),
                  ),
                ),
                Positioned(
                  top: 100,
                  left: 250,
                  child: CustomPaint(
                    painter: MasterPainter2(),
                    child: const SizedBox(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 100, left: 40, right: 40, bottom: 40),
                  child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: Settingcardmodellist.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 70),
                      itemBuilder: (context, index) {
                        return settingcard(
                          Settingcardmodel: Settingcardmodellist[index],
                          onchanged: isolateonchanged(index),
                          isolatedval: isolatevalue(index),
                        );
                      }),
                ),
              ],
            )),
      );
    });
  }

  bool isolatevalue(int index) {
    if (index == 0) {
      return BlocProvider.of<fingerprintcubit>(context).switchvalue;
    } else if (index == 1) {
      return context.read<ThemeCubit>().state.brightness == Brightness.dark;
    } else {
      return switchvalue3;
    }
  }

  void Function(bool) isolateonchanged(int index) {
    if (index == 0) {
      return (val) {
        BlocProvider.of<fingerprintcubit>(context)
            .switchonfingerprint(context, val, mounted);
      };
    } else if (index == 1) {
      return (valueee) {
        context.read<ThemeCubit>().toggleTheme();
      };
    } else {
      return (va) {
        switchvalue3 = !switchvalue3;
        setState(() {});
      };
    }
  }
}
