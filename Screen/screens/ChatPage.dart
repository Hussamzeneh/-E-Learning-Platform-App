import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/Cubit/Login%20cubit/profilecubit.dart';
import 'package:untitled4/Custom_widget/chatwidget/ChatTextfiled.dart';
import 'package:untitled4/Custom_widget/chatwidget/avatarchatlist.dart';
import 'package:untitled4/Model/Message.dart';
import 'package:untitled4/Model/chatavatrmodel.dart';
import 'package:untitled4/constans.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Custom_widget/genral/Custom_text_filed.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
  final String reciveruseremail;
  final String reciveruserid;
  const ChatPage(
      {super.key, required this.reciveruseremail, required this.reciveruserid});
}

class _ChatPageState extends State<ChatPage> {
  chatavatarmodel? Chatmodel;

  @override
  String? messagetext;

  List<String> messagelist = [];
  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('createdat', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> listmessage1 = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              listmessage1.add(Message.fromJson(snapshot.data!.docs[i]));
            }

            return Scaffold(
              //IconButton(icon: Icon(Icons.send , color: KSecondarycolor) , onPressed: (){
              //
              //           messagelist.add(messagetext!);
              //           sendmessage();
              //
              //
              //           setState(() {
              //
              //           });
              //         }),

              resizeToAvoidBottomInset: true,
              bottomNavigationBar: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context)
                      .viewInsets
                      .bottom, // Adjusts padding based on keyboard height
                ),
                child: ChatTextfiled(
                  send: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: KLSecondarycolor,
                        boxShadow: [
                          BoxShadow(
                              color: KLSecondarycolor.withOpacity(.25),
                              offset: const Offset(0, 4),
                              blurRadius: 20,
                              spreadRadius: 0)
                        ]),
                    child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: () {
                          // sendmessage();
                          //
                          //
                          // setState(() {
                          //
                          // });
                        }),
                  ),
                  controller: controller,
                  onSubmited: (message) {
                    messagetext = controller.text;
                    messagelist.add(messagetext!);
                    print(message);
                    print(BlocProvider.of<Profilecubit>(context)
                        .studentdata!
                        .email);
                    print(
                      DateTime.now(),
                    );

//
                    print(controller.text);
                    messages.add({
                      'message': message,
                      'createdat': DateTime.now(),
                      'id': BlocProvider.of<Profilecubit>(context)
                          .studentdata!
                          .email
                    });

                    controller.clear();
                    _controller.animateTo(0,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeIn);
                  },
                ),
              ),

              backgroundColor: KLPrimarycolor,
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Container(
                      decoration:
                          BoxDecoration(color: KLPrimarycolor, boxShadow: [
                        BoxShadow(
                            color: KLSecondarycolor.withOpacity(.25),
                            offset: const Offset(0, 4),
                            blurRadius: 20,
                            spreadRadius: 0)
                      ]),
                      child: ListTile(
                        tileColor: Colors.white,
                        trailing: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 12.0),
                              child: Icon(
                                Icons.call,
                                color: KLSecondarycolor,
                                size: 30,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 12.0),
                              child: Icon(
                                Icons.videocam,
                                color: KLSecondarycolor,
                                size: 30,
                              ),
                            )
                          ],
                        ),
                        title: const Text('anas asfahani '),
                        subtitle: const Text('online'),
                        leading: SizedBox(
                          height: 80,
                          width: 80,
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.yellow,
                            child: ClipOval(
                                child: Image.asset(
                              'lib/images/OIP (5).jpg',
                              height: 60,
                              width: 60,
                              fit: BoxFit.cover,
                            )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: ListView.builder(
                          reverse: true,
                          controller: _controller,
                          itemCount: listmessage1.length,
                          itemBuilder: (context, index) {
                            return listmessage1[index].id ==
                                    BlocProvider.of<Profilecubit>(context)
                                        .studentdata!
                                        .email
                                ? mymessage1(
                                    ownmeessage: listmessage1[index],
                                  )
                                : frendmessage1(
                                    ownmessage: listmessage1[index]);
                          }),
                    ),
                  )

//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.only(bottom: 8.0),
//             child: ListView(children: [
//               Align(
//                 alignment: Alignment.topLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 16.0 , top: 18),
//                   child: Container(
//                     child: Center(child: Text('hello man' , style: TextStyle(color: Colors.white),)),
//                     height: 40,
//                     width: 90,
//                     decoration: BoxDecoration(
//                         color: KSecondarycolor,
//                         borderRadius: BorderRadius.only(topRight: Radius.circular(20) , topLeft:   Radius.circular(20) , bottomRight:  Radius.circular(20))
//
//
//
//                     ),),
//                 ),
//               ) ,  Align(
//                 alignment: Alignment.topRight,
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 16.0 , top: 18),
//                   child: Container(
//                     constraints: BoxConstraints(maxWidth: 300),
//                     child: Center(child: Text('welcome baby can you shut up' , style: TextStyle(color: Colors.white),)),
//                     height: 65,
//
//                     decoration: BoxDecoration(
//                         color: KThirdarycolor,
//                         borderRadius: BorderRadius.only(topRight: Radius.circular(20) , topLeft:   Radius.circular(20) , bottomLeft:  Radius.circular(20))
//
//
//
//                     ),),
//                 ),
//               ) ,  Align(
//                 alignment: Alignment.topRight,
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 16.0 , top: 18),
//                   child: Container(
//                     constraints: BoxConstraints(maxWidth: 300),
//                     child: Center(child: Text('welcome baby can you shut up' , style: TextStyle(color: Colors.white),)),
//                     height: 65,
//
//                     decoration: BoxDecoration(
//
//                         color: KThirdarycolor,
//                         borderRadius: BorderRadius.only(topRight: Radius.circular(20) , topLeft:   Radius.circular(20) , bottomLeft:  Radius.circular(20))
//
//
//
//                     ),),
//                 ),
//               ) ,  Align(
//                 alignment: Alignment.topRight,
//                 child: Padding(
//                   padding: const EdgeInsets.only(right: 16.0 , top: 18),
//                   child: Container(
// constraints: BoxConstraints(maxWidth: 300),
//                     child: Center(child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text('welcome baby can you shut up' , style: TextStyle(color: Colors.white),),
//                     )),
// height: 65,
//
//                     decoration: BoxDecoration(
//                         color: KThirdarycolor,
//                         borderRadius: BorderRadius.only(topRight: Radius.circular(20) , topLeft:   Radius.circular(20) , bottomLeft:  Radius.circular(20))
//
//
//
//                     ),),
//                 ),
//               ),  Align(
//                 alignment: Alignment.topLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 16.0 , top: 18),
//                   child: Container(
//                     constraints: BoxConstraints(maxWidth: 300),
//                     child: Center(child: Text('i will catch you and learn you the resbect' , style: TextStyle(color: Colors.white),)),
//                     height: 65,
//
//                     decoration: BoxDecoration(
//                         color: KSecondarycolor,
//                         borderRadius: BorderRadius.only(topRight: Radius.circular(20) , topLeft:   Radius.circular(20) , bottomRight:  Radius.circular(20))
//
//
//
//                     ),),
//
//                 ),
//
//               ) , Align(
//     alignment: Alignment.topRight,
//     child: Padding(
//     padding: const EdgeInsets.only(right: 16.0 , top: 18),
//     child: Container(
//     constraints: BoxConstraints(maxWidth: 300),
//     child: Center(child: Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Text('ok see you at 6 am in the mol' , style: TextStyle(color: Colors.white),),
//     )),
//     height: 65,
//
//     decoration: BoxDecoration(
//     color: KThirdarycolor,
//     borderRadius: BorderRadius.only(topRight: Radius.circular(20) , topLeft:   Radius.circular(20) , bottomLeft:  Radius.circular(20))
//
//
//
//     ),),
//     ),
//     ) ,  Align(
//                 alignment: Alignment.topLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 16.0 , top: 18),
//                   child: Container(
//                     child: Center(child: Text('hello man' , style: TextStyle(color: Colors.white),)),
//                     height: 40,
//                     width: 90,
//                     decoration: BoxDecoration(
//                         color: KSecondarycolor,
//                         borderRadius: BorderRadius.only(topRight: Radius.circular(20) , topLeft:   Radius.circular(20) , bottomRight:  Radius.circular(20))
//
//
//
//                     ),),
//                 ),
//               ) ,  Align(
//                 alignment: Alignment.topLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 16.0 , top: 18),
//                   child: Container(
//                     child: Center(child: Text('hello man' , style: TextStyle(color: Colors.white),)),
//                     height: 40,
//                     width: 90,
//                     decoration: BoxDecoration(
//                         color: KSecondarycolor,
//                         borderRadius: BorderRadius.only(topRight: Radius.circular(20) , topLeft:   Radius.circular(20) , bottomRight:  Radius.circular(20))
//
//
//
//                     ),),
//                 ),
//               ) ,  Align(
//                 alignment: Alignment.topLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 16.0 , top: 18),
//                   child: Container(
//                     child: Center(child: Text('hello man' , style: TextStyle(color: Colors.white),)),
//                     height: 40,
//                     width: 90,
//                     decoration: BoxDecoration(
//                         color: KSecondarycolor,
//                         borderRadius: BorderRadius.only(topRight: Radius.circular(20) , topLeft:   Radius.circular(20) , bottomRight:  Radius.circular(20))
//
//
//
//                     ),),
//                 ),
//               ) ,  Align(
//                 alignment: Alignment.topLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 16.0 , top: 18),
//                   child: Container(
//                     child: Center(child: Text('hello man' , style: TextStyle(color: Colors.white),)),
//                     height: 40,
//                     width: 90,
//                     decoration: BoxDecoration(
//                         color: KSecondarycolor,
//                         borderRadius: BorderRadius.only(topRight: Radius.circular(20) , topLeft:   Radius.circular(20) , bottomRight:  Radius.circular(20))
//
//
//
//                     ),),
//                 ),
//               ) ,  Align(
//                 alignment: Alignment.topLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 16.0 , top: 18),
//                   child: Container(
//                     child: Center(child: Text('hello man' , style: TextStyle(color: Colors.white),)),
//                     height: 40,
//                     width: 90,
//                     decoration: BoxDecoration(
//                         color: KSecondarycolor,
//                         borderRadius: BorderRadius.only(topRight: Radius.circular(20) , topLeft:   Radius.circular(20) , bottomRight:  Radius.circular(20))
//
//
//
//                     ),),
//                 ),
//               ) ,  Align(
//                 alignment: Alignment.topLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 16.0 , top: 18),
//                   child: Container(
//                     child: Center(child: Text('hello man' , style: TextStyle(color: Colors.white),)),
//                     height: 40,
//                     width: 90,
//                     decoration: BoxDecoration(
//                         color: KSecondarycolor,
//                         borderRadius: BorderRadius.only(topRight: Radius.circular(20) , topLeft:   Radius.circular(20) , bottomRight:  Radius.circular(20))
//
//
//
//                     ),),
//                 ),
//               ) ,  Align(
//                 alignment: Alignment.topLeft,
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 16.0 , top: 18),
//                   child: Container(
//                     child: Center(child: Text('hello man' , style: TextStyle(color: Colors.white),)),
//                     height: 40,
//                     width: 90,
//                     decoration: BoxDecoration(
//                         color: KSecondarycolor,
//                         borderRadius: BorderRadius.only(topRight: Radius.circular(20) , topLeft:   Radius.circular(20) , bottomRight:  Radius.circular(20))
//
//
//
//                     ),),
//                 ),
//               )
//             ],),
//           ),
//         )
                ],
              ),
            );
          } else {
            return const Text('loaaaaging');
          }
        });
  }
  // void sendmessage(){
  //
  //   messagetext = controller.text;
  //   messagelist.add(messagetext!);
  //   controller.clear();
  //   print(controller.text);
  //   messages.add({
  //     'message': controller.text
  //
  //   });
  //
  //
  //
  //
  // }
}

class mymessage1 extends StatelessWidget {
  mymessage1({super.key, required this.ownmeessage});
  Message ownmeessage;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 16.0, top: 18, right: 18, bottom: 18),
        child: Container(
          constraints: const BoxConstraints(minWidth: 80, maxHeight: 100),
          decoration: const BoxDecoration(
              color: KLSecondarycolor,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50))),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              ownmeessage.message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

class frendmessage1 extends StatelessWidget {
  frendmessage1({super.key, required this.ownmessage});
  Message ownmessage;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 16.0, top: 18, right: 18, bottom: 18),
        child: Container(
          constraints: const BoxConstraints(minWidth: 80, maxHeight: 100),
          decoration: const BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50))),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              ownmessage.message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}


//AIzaSyA7KGzcWfQ5kSMzPnkl-ZKEXWohyjyO51s gemeni api key