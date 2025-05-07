import 'dart:io';

abstract class profileimagestate {}
class initialstate extends profileimagestate{}

class fromcamera extends profileimagestate{}

class avatar1 extends profileimagestate{}
class notavatar1 extends profileimagestate{}
class Pickedimage extends profileimagestate{
  File image ;

  Pickedimage(this.image);
}
class notpickedimage extends profileimagestate{}
class notdeleteimage extends profileimagestate{}
class deleteimage extends profileimagestate{}
class fromgallery extends profileimagestate{
  File  ? imagegallery ;
  fromgallery(this.imagegallery);



}
class notfromgalleery extends profileimagestate{

}
