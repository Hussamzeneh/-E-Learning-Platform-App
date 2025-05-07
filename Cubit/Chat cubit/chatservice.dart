import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:untitled4/Model/mochimessage.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> sendmessage(String reciverid, String message) async {
    final String currentid = _firebaseAuth.currentUser!.uid;
    final String currentemail = _firebaseAuth.currentUser!.email.toString();
    MochiMessage newmessage = MochiMessage(
      message: message,
      reciverid: reciverid,
      senderemail: currentemail,
      senderid: currentid,
      timestamp: Timestamp.now(),
      seen: false, // Set seen to false initially
    );

    List<String> ids = [currentid, reciverid];
    ids.sort();
    String chatroomid = ids.join("_");
    await _firebaseFirestore
        .collection('chatrooms')
        .doc(chatroomid)
        .collection('Messages')
        .add(newmessage.toMap());
  }

  Stream<QuerySnapshot> getmessages(String userid, String otheruserid) {
    List<String> ids = [userid, otheruserid];
    ids.sort();
    String chatroomid = ids.join("_");
    return _firebaseFirestore
        .collection('chatrooms')
        .doc(chatroomid)
        .collection('Messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }

  Future<void> markMessageAsSeen(String chatroomid, String messageId) async {
    await _firebaseFirestore
        .collection('chatrooms')
        .doc(chatroomid)
        .collection('Messages')
        .doc(messageId)
        .update({'seen': true});
  }

  void listenForMessages(String userid, String otheruserid) {
    List<String> ids = [userid, otheruserid];
    ids.sort();
    String chatroomid = ids.join("_");

    _firebaseFirestore
        .collection('chatrooms')
        .doc(chatroomid)
        .collection('Messages')
        .snapshots()
        .listen((snapshot) {
      for (var doc in snapshot.docs) {
        if (doc['reciverid'] == userid && !doc['seen']) {
          markMessageAsSeen(chatroomid, doc.id);
        }
      }
    });
  }
}
