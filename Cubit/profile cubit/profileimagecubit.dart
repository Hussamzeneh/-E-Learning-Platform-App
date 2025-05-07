import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttermoji/fluttermoji.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled4/Cubit/profile%20cubit/profileimagestate.dart';
bool frommcamera = false ;
bool orginalavatar = false ;
class ProfileImageCubit extends Cubit<profileimagestate>{
  ProfileImageCubit() : super(initialstate()) {




  }
  bool bacimage = false ;
  bool avatarimage = false ;

  String embty = '';

  String ?backenimage ;

  File ?image  ;
  File  ? imagegallery ;


  final imagePicker = ImagePicker();


  emptypic (bool deletephot){
    if (deletephot){
      emit(deleteimage());



    }else {
emit(notdeleteimage());

    }





  }




  Uploadimage ()async {
    var  pickedimage = await imagePicker.pickImage(source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);

    if(pickedimage != null){


        image =  File(pickedimage!.path);

        print('111111111111111111111111111111111');

        print(image);
        emit(Pickedimage(image!));

    }
    else{
      emit(notpickedimage());



    }


  }
  Uploadimage2 ()async {
    var  pickedimage = await imagePicker.pickImage(source: ImageSource.gallery, preferredCameraDevice: CameraDevice.front);

    if(pickedimage != null){


      imagegallery =  File(pickedimage!.path);

      print('111111111111111111111111111111111');

      print(image);
      emit(fromgallery(imagegallery!));

    }
    else{
      emit(notfromgalleery());



    }


  }



  useavatar(){
    if(orginalavatar){
      emit(avatar1());



    }else {
      emit(notavatar1());

    }



  }








//   Widget imagechoise(String bacoimage, File Fileimage2 , bool avatar2) {
//
//
//     if(frommcamera){
//
//
//       orginalavatar = false;
//       emit(fromcamera());
//       print(avatar2);
//
//
//       return FittedBox(fit: BoxFit.cover,child: Image.file(Fileimage2));
//
//
//
//
//
//     }else if ( orginalavatar){
//
//
//      frommcamera = false;
//      emit(avatar1());
//
//      return FittedBox(fit: BoxFit.cover,child: FluttermojiCircleAvatar());
//
//     }
//
//
//    else{
//      emit(initialstate());
//       return FittedBox(fit: BoxFit.cover,child: Image.asset(bacoimage));
//     }
//
//
//
// }




}