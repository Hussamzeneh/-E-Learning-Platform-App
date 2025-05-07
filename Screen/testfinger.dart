// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// import '../Custom_widget/codewidget.dart';
// import '../Custom_widget/profilinfo.dart';
// import '../Functions/finger_print.dart';
// import 'LoginPage.dart';
//
// class testfinger extends StatefulWidget {
//   const testfinger({super.key});
//
//   @override
//   State<testfinger> createState() => _testfingerState();
// }
//
// class _testfingerState extends State<testfinger> {
//
//
//
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     loaduser();
//   }
//   String ?name ;
//   String ? username;
//
//
//
//   void loaduser()async {
//     fprint = await _flutterSecureStorage.read(key: "fingerprint") ?? '';
//     _switchvalue = fprint.isNotEmpty;
//     setState(() {
//
//
//     });
//
//
//
//
//
//
//   }
//
//   bool _switchvalue = false;
//
//   String fprint = '';
//
//   fingerprint _fingerprint = fingerprint() ;
//
//   FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage(
//     aOptions: AndroidOptions(encryptedSharedPreferences: true)
//
//   );
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: ListView(children: [
//         profileinfo(first: 'fingerprint', second: Switch(value: _switchvalue ,onChanged: (value){
//           _enablefingerprint(value) ;
//
//
//         } ,)) ,
//
//         profileinfo(first: 'fingerprint', second: Switch(value: _switchvalue ,onChanged: (value){
//           _enablefingerprint(value) ;
//
//
//         } ,)) ,
//         SwitchListTile(
//           tileColor: Colors.red,
//           selectedTileColor: Colors.yellow,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
//           activeColor: Colors.green,
//             inactiveThumbColor: Colors.red,
//             title: Text('finger print '),
//             value: _switchvalue ,  onChanged: (value){
//           _enablefingerprint(value);
//         }) ,
//
//         profileinfo(first: 'fingerprint', second: Switch(value: _switchvalue ,onChanged: (value){
//           _enablefingerprint(value) ;
//
//
//         } ,)) ,
//         GridView.builder(
//           itemCount: 10,
//             physics: NeverScrollableScrollPhysics (),
//             shrinkWrap: true,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5), itemBuilder: (context , index){
//           return Container();
//
//         }) ,
//
//         GestureDetector(
//           onTap: (){
//             Navigator.push(context, MaterialPageRoute(builder: (context){
//               return LoginPage();
//             }));
//           } ,
//           child: Container(
//             color: Colors.red,
//             child: Text('log out'),),
//         )
//
//
//
//
//
//       ],),
//
//
//
//     );
//   }
//   void _enablefingerprint(value)async {
//     if (value){
//       bool isfingerprintenable = await _fingerprint.isfingerprintenabeled();
//       if (isfingerprintenable){
//
//         await _flutterSecureStorage.write(key: "fingerprint", value:"checked" );
//         if(!mounted){
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('finger print is enabeled')));
//         }
//
//
//       }
//
//
//     }
//     else {
//       await _flutterSecureStorage.delete(key: "fingerprint");
//
//
//     }
//     setState(() {
//       _switchvalue = value ;
//     });
//
//
//   }
//
// }
