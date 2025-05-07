import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled4/Cubit/Login%20cubit/fingerprintcubit.dart';
import 'package:untitled4/Cubit/Login%20cubit/login_cubit.dart';
import 'package:untitled4/Cubit/Login%20cubit/profilecubit.dart';
import 'package:untitled4/Custom_widget/genral/newpinkled.dart';
import '../Custom_widget/Login_widget/buildfingerprintblocbuilder.dart';
import '../Custom_widget/Login_widget/buildgridviewcodebox.dart';
import '../Custom_widget/Login_widget/buildtextfiledbloc.dart';
import '../Custom_widget/Login_widget/buttongesterdetector.dart';
import '../Custom_widget/Login_widget/forgetpasswordandreset.dart';
import '../Custom_widget/genral/BlueLed.dart';
import '../Custom_widget/genral/main_title.dart';
import '../Custom_widget/genral/topclib.dart';


class LoginPage extends StatelessWidget {
  bool viseee = false;

  TextEditingController passwordcontroller = TextEditingController();
  List<TextEditingController> controllers =
      List.generate(5, (index) => TextEditingController());

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return BlocProvider(
    create: (context) => Profilecubit(),
      child: BlocProvider(
      create: (context) => logincubit(),
        child: BlocProvider(
          create: (context) => fingerprintcubit() ,
          child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: topclib(
                  Child2: Center(
                      child: maintitle(
                    text1: 'E D U',
                    text2: ' S P H ',
                    text3: 'E R E ',
                  )),
                  screensize: screensize,
                  Child: Stack(
                    children: [
                      pinkled(screensize.height - 250.h, 50.w),
                      BlueLed((30 / screensize.height) * screensize.height,
                          (250 / screensize.width) * screensize.width),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                        child: Column(children: [
                          SizedBox(
                            height: 40.h,
                          ),
                          Text(
                            'LOG IN',
                            style: TextStyle(
                                fontFamily: 'Pacifico',
                                fontWeight: FontWeight.bold,
                                fontSize: 25.sp,
                                color: Theme.of(context).textTheme.bodyLarge?.color),
                          ),
                          SizedBox(
                            height: 30.h,
                          ),
                          buildGridViewcodebox(controllers),
                          SizedBox(
                            height: 30.h,
                          ),
                          buildBlocConsumertextfiled(
                              screensize, passwordcontroller, viseee),
                          SizedBox(
                            height: 40.h,
                          ),

                          buttongesterdetector(
                              finalOutput: controllers.map((e) => e.text).join(),
                              password: passwordcontroller.text,
                              controllers: controllers,
                              passwordcontroller: passwordcontroller),
                          const Forgetpasswordandreset(),
                          SizedBox(
                            height: 10.h,
                          ),
                          buildfingerprintBlocBuilder(),
                        ]),
                      ),
                    ],
                  ))),
        ),
      ),
    );
  }
}
