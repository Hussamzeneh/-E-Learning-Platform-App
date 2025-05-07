import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:untitled4/Custom_widget/chatwidget/avatarchatlist.dart';

import 'package:untitled4/Custom_widget/genral/topclib.dart';
import 'package:untitled4/Screen/ChatPage.dart';
import 'package:untitled4/Screen/mochichatpage.dart';

import '../Custom_widget/genral/FilterBar.dart';

import '../Custom_widget/genral/Master_Painter2.dart';
import '../Custom_widget/genral/master_painter.dart';

int? number;

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({super.key});

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.tertiary,
              Theme.of(context).colorScheme.onTertiary
            ])),
          ),
          title: const Text('  CHAT',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30)),
          centerTitle: true,
          elevation: 0,
        ),
        body: topclib(
            screensize: size,
            Child2: Padding(
              padding: const EdgeInsets.only(
                  left: 60.0, right: 60, bottom: 30, top: 35),
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FilterBar(
                        text: 'Students',
                        index: 0,
                        isSelected: _selectedIndex == 0,
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 0;
                          });
                        },
                      ),
                      FilterBar(
                        text: 'Teacher',
                        index: 1,
                        isSelected: _selectedIndex == 1,
                        onPressed: () {
                          setState(() {
                            _selectedIndex = 1;
                          });
                        },
                      ),
                    ],
                  )),
            ),
            Child: Padding(
              padding: const EdgeInsets.only(top: 35.0),
              child: Stack(
                children: [
                  Positioned(
                    top: 550.h,
                    left: 60.w,
                    child: CustomPaint(
                      painter: MasterPainter(),
                      child: const SizedBox(),
                    ),
                  ),
                  Positioned(
                    top: 150.h,
                    left: 350.w,
                    child: CustomPaint(
                      painter: MasterPainter2(),
                      child: const SizedBox(),
                    ),
                  ),
                  _builduserlist(),
                ],
              ),
            )

            ));
  }

  Widget _builduserlist() {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('eroor is : ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(

              color: Colors.pink,
            ));
          }
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ListView.builder(
                itemCount: snapshot.data!.docs
                    .map<Widget>((doc) => _buildUserListItem(doc, context))
                    .toList()
                    .length,
                itemBuilder: (context, index) {
                  print(
                      'map is ${snapshot.data!.docs.map<Widget>((doc) => _buildUserListItem(doc, context)).toList()[index]}');

                  return snapshot.data!.docs
                      .map<Widget>((doc) => _buildUserListItem(doc, context))
                      .toList()[index];
                },

                // children: snapshot.data!.docs.map<Widget>((doc) => _buildUserListItem(doc , context)).toList()
              ),
            );
          }
          return const SizedBox();
        });
  }

  Widget _buildUserListItem(DocumentSnapshot document, BuildContext context) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if (_auth.currentUser!.email == data['email']) {
      print('===================');
      print(_auth.currentUser!.email);
      number = data['classlevel'];
    }
    print(number);
    print('data is $data');

    print('current email is ${_auth.currentUser!.email}');
    if (_selectedIndex == 0 &&
        _auth.currentUser!.email != data['email'] &&
        data['classlevel'] == number &&
        data['role'] == 'student') {
      return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return
              MochiChatPage(reciveruserid: data['uid'], reciveruseremail: data['firstname'], data: data);


            }));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: avatarchatlisttile(
              data: data,
            ),
          ));

      //   ListTile(
      //   title:Text(data['email']) ,
      //   subtitle: Text(data['uid']),
      //   onTap: (){
      //
      //
      //     Navigator.push(context, MaterialPageRoute(builder: (context){
      //       return
      //         mochichatpage(reciveruseremail: data['email'],reciveruserid:data['uid'] ,);
      //     }));
      //
      //   },
      // );
    } else if (_selectedIndex == 1 &&
        _auth.currentUser!.email != data['email'] &&
        data['classlevel'] == number &&
        data['role'] == 'teacher') {
      print(
          '----------------------------------------------------------------index = 1');

      return GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return   MochiChatPage(reciveruserid: data['uid'], reciveruseremail: data['firstname'], data: data);
            }));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: avatarchatlisttile(
              data: data,
            ),
          ));
    } else {
      return Container();
    }
  }
}
