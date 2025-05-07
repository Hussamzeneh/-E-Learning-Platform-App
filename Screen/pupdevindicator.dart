import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled4/Cubit/Login%20cubit/profilestates.dart';
import '../Custom_widget/ onboardingwidget/bottomclip.dart';
import 'LoginPage.dart';


class OnBoarding extends StatefulWidget {
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final controller = PageController();

  final List<String> imagelist = [
    'lib/images/Meet-the-delicious-3D-caricature-of-the-Brazilian-artist-Gabriel-Soares40-Pics-63d8f0fcd0b4c__880-removebg-preview.png',
    'lib/images/OIP-removebg-preview.png',
    'lib/images/uddhav-thackeray-ai-uddhav-thackeray-cartoon-3d-uddhav-thackeray-images_1002350-255-removebg-preview.png',
    'lib/images/caricaturer-portraits-personnes-souriantes-dans-style-annees-70_954932-96-removebg-preview.png',
  ];

  final List<String> subtitlelist = [
    'Discover new skills with personalize interactive courses designed just for you Embark on a journey of growth and mastery with content tailored to your pace and interests',
    'Stay motivated by tracking your learning progress See how far you have come and whats next on your path to success with our intuitive progress tracker',
    'Engage with interactive lessons and hands on activities Each module is designed to make learning fun and effective with practical exercises that reinforce your understandin',
    'Become a part of our vibrant learning community Connect with fellow learners, share insights and collaborate on projects to deepen your learning experience'
  ];

  final List<String> titlelist = [
    'Welcome to EDUSPHERE!',
    'Track Your Progress',
    'Interactive Lessons',
    'Join a Community'
  ];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //isseen() ;
  }
  Future <void> isseen()async{

    SharedPreferences prefs = await SharedPreferences.getInstance() ;
    bool isseen = prefs.getBool('isSeen') ?? false;
    if (isseen){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return LoginPage() ;
      }));
    }else{


    }

  }
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          bottomclib(
            screensize: screensize,
          ),
          Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 6),
                  Expanded(
                    flex: 4,
                    child: PageView.builder(
                      controller: controller,
                      itemCount: imagelist.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.symmetric(horizontal: 10.w),
                              child: Image.asset(
                                imagelist[index],
                                height: 400.h,
                                width: 400.w,
                              ),
                            ),
                            Positioned(
                              left: screensize.width / 4.w,
                              right: screensize.width / 9.w,
                              bottom: screensize.height / 14.h,
                              child: Column(
                                children: [
                                  Text(
                                    titlelist[index],
                                    textAlign: TextAlign.center,
                                    style:  TextStyle(
                                        color: Colors.pink,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22.sp),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Text(
                                    subtitlelist[index],
                                    maxLines: 6,
                                    textAlign: TextAlign.start,
                                    style:  TextStyle(
                                        fontSize: 16.sp, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),

                            index == 3
                                ? Positioned(
                               top: (screensize.height - 70.h),
                                     right: 10.w,

                                    child: GestureDetector(
                                       onTap: ()async{

                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isSeen', true);
                        Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                        } ,
                                      child: Container(
                                        height: 50.h,

                                        decoration: BoxDecoration(
                                            color: Colors.pink,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child:  Center(
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 50.0.w),
                                              child: Text(
                                                                                      'NEXT',
                                                                                      style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 25.sp),
                                                                                    ),
                                            )),
                                      ),
                                    ))
                                : const SizedBox()
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                top: screensize.height / 1.6,
                left: screensize.width / 2 - 50,
                child: SmoothPageIndicator(
                  controller: controller,
                  count: imagelist.length,
                  effect: const WormEffect(
                    type: WormType.normal,
                    dotHeight: 12,
                    dotWidth: 12,
                    spacing: 16,
                    dotColor: Colors.grey,
                    activeDotColor: Colors.pink,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


