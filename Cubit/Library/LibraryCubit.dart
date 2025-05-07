import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:untitled4/Cubit/Library/LibraryStates.dart';
import 'package:http/http.dart' as http;
import 'package:untitled4/Model/Librarybookmodel.dart';

import '../../constans.dart';

class LibraryCubit extends Cubit<Librarystates>{
  LibraryCubit() : super(intiallibrary()){
    getbookbytype(type: 'show_educational_book');
  }
  LibraryModel ?bookModel ;
  Set<LibraryModel> booklists = {};

  Future<Set<LibraryModel>?>  getbookbytype({required String type})async{
     emit(loadinglibrary());
try{

  http.Response response = await http.get(Uri.parse('http://${KURL}:8000/api/$type') );
  var data = jsonDecode(response.body);
  booklists.clear() ;
  data.forEach((element) =>
      booklists.add(LibraryModel.fromJson(element)));
  data.forEach((element) =>
  bookModel = LibraryModel.fromJson(element));
  emit(successlibrary());
  return booklists ;




}catch(e){
  emit(feuliurlibrary());
}







   }




}