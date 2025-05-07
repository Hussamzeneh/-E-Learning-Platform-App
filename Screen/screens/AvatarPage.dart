import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:untitled4/Cubit/profile%20cubit/profileimagecubit.dart';
import 'package:untitled4/constans.dart';


import '../Custom_widget/fluttermoje_widget/fluttermojeedit.dart';
import '../Custom_widget/genral/Master_Painter2.dart';
import '../Custom_widget/genral/master_painter.dart';
bool avatarsetprofile = false ;
class AvatarPage extends StatefulWidget {
  const AvatarPage({super.key});

  @override
  State<AvatarPage> createState() => _AvatarPageState();
}

class _AvatarPageState extends State<AvatarPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        appBar: AppBar(
          title:     Text('Lets make your Avatar ' , style: TextStyle(color: Colors.pink , fontSize: 30 , fontWeight: FontWeight.bold), ),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          elevation: 0 ,
          leading: IconButton(onPressed: (){
            Navigator.pop(context);

          } , icon: Icon(Icons.arrow_back_ios_new_outlined , color: Theme.of(context).colorScheme.tertiaryFixed,)),

        ),
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Stack(
          children: [

            Positioned(
              top: 650,
              left: 20,
              child: CustomPaint(
                painter: MasterPainter(),
                child: SizedBox(),

              ),
            ) , Positioned(
              top: 100,
              left: 350,
              child: CustomPaint(
                painter: MasterPainter2(),
                child: SizedBox(),

              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 80.0),
              child: Container(
                child: Column(

                  children: [

                    Center(child: Padding(
                      padding: const EdgeInsets.only(top: 60.0),
                      child: Container(
                          decoration: BoxDecoration(color: Colors.grey.withOpacity(.1),
                            border: Border.all(color: KLSecondarycolor.withOpacity(.1))

                          ),
                          child: FluttermojiCircleAvatar(radius: 150,backgroundColor: Colors.transparent,)),
                    )),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.push(context,
                              new MaterialPageRoute(builder: (context) => NewPage()));


                        },
                        child: Container(
                          child: Center(child:ListTile(

                            trailing: Icon(Icons.edit , color: Theme.of(context).colorScheme.tertiaryFixed, size: 25,),
                            title: Text('Edit your avatar' , style: TextStyle(color: Theme.of(context).colorScheme.tertiaryFixed , fontSize: 25), ),)),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondaryContainer ,
                            boxShadow: [
                              BoxShadow(
                                  color: KLSecondarycolor.withOpacity(.25),
                                  offset: Offset(0, 4),
                                  blurRadius: 20,
                                  spreadRadius:0)

                            ]
                        ),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: GestureDetector(
                        onTap: (){
                          orginalavatar = true;
                          print('orgiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
                          print(orginalavatar);
                          BlocProvider.of<ProfileImageCubit>(context).useavatar();




                        },
                        child: Container(
                          child: Center(child:ListTile(

                            trailing: Icon(Icons.face , color: Theme.of(context).colorScheme.tertiaryFixed, size: 25,),
                            title: Text('Set avatar profile image' , style: TextStyle(color: Theme.of(context).colorScheme.tertiaryFixed , fontSize: 25), ),)),
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(color: Theme.of(context).colorScheme.secondaryContainer ,
                              boxShadow: [
                                BoxShadow(
                                    color: KLSecondarycolor.withOpacity(.25),
                                    offset: Offset(0, 4),
                                    blurRadius: 20,
                                    spreadRadius:0)

                              ]
                          ),),
                      ),
                    ),
                  ],
                ),



              ),
            ),
          ],
        ),



      ),


    );
  }
}
