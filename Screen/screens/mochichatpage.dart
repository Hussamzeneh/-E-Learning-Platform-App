import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:untitled4/Cubit/Chat%20cubit/chatservice.dart';


import '../Custom_widget/chatwidget/ChatTextfiled.dart';
import '../Custom_widget/chatwidget/freinfmessage.dart';
import '../Custom_widget/genral/Master_Painter2.dart';
import '../Custom_widget/genral/master_painter.dart';
import '../Custom_widget/chatwidget/mymessage.dart';
import '../constans.dart';

class MochiChatPage extends StatefulWidget {
  final String reciveruseremail;
  final String reciveruserid;
  final Map<String, dynamic> data;

  MochiChatPage({
    required this.reciveruserid,
    required this.reciveruseremail,
    required this.data,
  });

  @override
  State<MochiChatPage> createState() => _MochiChatPageState();
}

class _MochiChatPageState extends State<MochiChatPage> {
  final TextEditingController messagecontroller = TextEditingController();
  final ChatService _Chatservice = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final listviewcontroler  = ScrollController();

  @override
  void initState() {
    super.initState();
    _Chatservice.listenForMessages(_firebaseAuth.currentUser!.uid, widget.reciveruserid);
  }

  void sendmessage() async {
    if (messagecontroller.text.isNotEmpty) {
      listviewcontroler.animateTo(listviewcontroler.position.extentTotal , duration: Duration(seconds: 1), curve: Curves.easeIn);
      await _Chatservice.sendmessage(widget.reciveruserid, messagecontroller.text);
      messagecontroller.clear();



    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // Adjusts padding based on keyboard height
        ),
        child: ChatTextfiled(
          send: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Theme.of(context).colorScheme.outline,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.outline.withOpacity(.25),
                  offset: Offset(0, 4),
                  blurRadius: 20,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: IconButton(
              icon: Icon(Icons.send, color: Colors.white),
              onPressed: (){
                sendmessage();

              }
            ),
          ),
          controller: messagecontroller,
        ),
      ),
      appBar: AppBar(
        leadingWidth: 40,
        backgroundColor: Colors.pink,
        title: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.yellow,
                child: ClipOval(
                  child: Image.network(
                    'http://${KURL}:8000${widget.data['profile_pic']}',
                    height: 60,
                    width: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text('${widget.data['firstname']} ${widget.data['lastname']}' , style: TextStyle(fontSize: 18 , fontWeight: FontWeight.bold , color: Colors.white),),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 550,
            left: 20,
            child: CustomPaint(
              painter: MasterPainter(),
              child: SizedBox(),
            ),
          ),
          Positioned(
            top: 30,
            left: 250,
            child: CustomPaint(
              painter: MasterPainter2(),
              child: SizedBox(),
            ),
          ),
          Column(
            children: [
              Expanded(child: _buildmessagelist()),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildmessagelist() {
    return StreamBuilder(
      stream: _Chatservice.getmessages(widget.reciveruserid, _firebaseAuth.currentUser!.uid),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading ...');
        }
        return ListView(
          controller: listviewcontroler,

          children: snapshot.data!.docs
              .map((document) => _buildmessageitem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildmessageitem(DocumentSnapshot document) {
    Map<String, dynamic> data1 = document.data() as Map<String, dynamic>;

    return data1['senderid'] == _firebaseAuth.currentUser!.uid
        ? MyMessage(
      ownMessage: data1['message'],
      seen: data1['seen'], // Pass seen status to the widget
    )
        : FriendMessage(data: data1 , image: widget.data['profile_pic'],);
  }
}
