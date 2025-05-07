




import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:untitled4/Model/models/uiddatamodel.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
uiddatamodel ?UIDMODEL;

// Function to register a new user with email and password
Future<UserCredential> registerUser(String email, String password , String profilepic , String firstname , String lastname , int classlevel , String role) async {
  try {

    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(

      email: email,
      password: password,
    );
    firestore.collection('users').doc(userCredential.user!.uid).set({
      'uid': userCredential.user!.uid,
      'email': email,
      'profile_pic': profilepic ,
      'firstname': firstname ,
      'lastname': lastname ,
      'classlevel': classlevel,
      'role': role
    }, SetOptions(merge: true));





    // User is successfully registered
    // You can now access user details with userCredential.user
    return userCredential;
  } on FirebaseAuthException catch (e) {
    // Handle errors here
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
    rethrow; // Re-throw the exception to be handled elsewhere
  }
}

// Function to sign in a user with email and password
Future<UserCredential> signInUser(String email, String password , String profilepic , String firstname , String lastname , int classlevel , String role) async {
  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(


      email: email,
      password: password,
    );
    // User is successfully signed in
    // You can now access user details with userCredential.user


    firestore.collection('users').doc(userCredential.user!.uid).set({
      'uid': userCredential.user!.uid,
      'email': email,
      'profile_pic': profilepic ,
      'firstname': firstname ,
      'lastname': lastname ,
      'classlevel': classlevel,
      'role': role
    }, SetOptions(merge: true));









    print(userCredential.user);
    return userCredential;
  } on FirebaseAuthException catch (e) {
    // Handle errors here
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
    rethrow; // Re-throw the exception to be handled elsewhere
  }
}
logoutuserfirebase()async{

  try{
     _auth.signOut();


  }on FirebaseException catch(e){
    print(e);
  }
}




