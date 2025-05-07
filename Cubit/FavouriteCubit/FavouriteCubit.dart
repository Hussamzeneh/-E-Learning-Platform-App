import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled4/Model/Librarybookmodel.dart';
import '../../Model/TeacherProfileModel.dart';
import '../Login cubit/profilecubit.dart';
import 'FavouriteStates.dart';
import '../../constans.dart';

class FavouriteCubit extends Cubit<FavouriteStates> {
  FavouriteCubit() : super(InitialState()) {
    getfavteacher();
  }


  orginalteachermodel? teacherProfileModel;
  Set<orginalteachermodel> productlists7 = {};
  Set<LibraryModel> favbooklist = {} ;

  LibraryModel ? favbookModel;

  Future<void> addFavouritebook({required String id}) async {
    try {
      final response = await http.post(
        Uri.parse('http://$KURL:8000/api/add_to_fav'),
        body: {'id': id},
        headers: {'Authorization': 'Bearer $firebasetoken1'},
      );
      if (response.statusCode == 200) {
        await _saveFavourite(id);
        emit(FavouriteAdded(id));
      } else {
        emit(FavouriteError('Failed to add to favourites'));
      }
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }

  Future<void> removeFavourite({required String id}) async {
    try {
      final response = await http.delete(
        Uri.parse('http://$KURL:8000/api/remove_from_fav/$id'),
        headers: {'Authorization': 'Bearer $firebasetoken1', 'Accept': 'application/json'},
      );
      if (response.body == 'the book deleted from favorite') {
        await _removeFavourite(id);
        emit(FavouriteRemoved(id));
      }else if(response.body == 'you can not delete this book'){
        await _removeFavourite(id);
        emit(FavouriteRemoved(id));

      }

      else {
        emit(FavouriteError('Failed to remove from favourites'));
      }
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }
  Future<Set<LibraryModel>?>  getfavbook()async{
      emit(Loadingfavbook());
      try{

        http.Response response = await http.get(Uri.parse('http://${KURL}:8000/api/show_fav_books') , headers: {

          'Authorization': 'Bearer $firebasetoken1'
        } );
        var data = jsonDecode(response.body);
        favbooklist.clear() ;
        data.forEach((element) =>
            favbooklist.add(LibraryModel.fromJson(element)));
        data.forEach((element) =>
        favbookModel = LibraryModel.fromJson(element));
        emit(Sucsesfavbook());
        return favbooklist ;




      }catch(e){
        emit(feuliurfavbook());
        print(e);
      }







    }
  Future<void> addFavouriteteacher({required String id}) async {
    try {
      final response = await http.post(
        Uri.parse('http://$KURL:8000/api/add_to_favorite'),
        body: {'id': id},
        headers: {'Authorization': 'Bearer $firebasetoken1'},
      );
      if (response.statusCode == 200) {
        await _saveFavouriteteacher(id);
        emit(FavouriteAdded(id));
      } else {
        emit(FavouriteError('Failed to add teacher to favourites'));
      }
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }
  Future<void> removeFavouriteteacher({required String id}) async {
    try {
      final response = await http.delete(
        Uri.parse('http://$KURL:8000/api/remove_from_favorite/$id'),
        headers: {'Authorization': 'Bearer $firebasetoken1', 'Accept': 'application/json'},
      );
      if (response.body == 'the teacher deleted from favorite') {
        await _removeFavouriteteacher(id);
        emit(FavouriteRemoved(id));
      }else if(response.body == 'you can not delete this , you are not the owner'){
        await _removeFavouriteteacher(id);
        emit(FavouriteRemoved(id));

      }

      else {
        emit(FavouriteError('Failed to remove from favourites'));
      }
    } catch (e) {
      emit(FavouriteError(e.toString()));
    }
  }
  Future<Set<orginalteachermodel>?>  getfavteacher()async{
    emit(Loadingfavbook());
    try{

      http.Response response = await http.get(Uri.parse('http://${KURL}:8000/api/show_favorite_teachers') , headers: {

        'Authorization': 'Bearer $firebasetoken1'
      } );
      var data = jsonDecode(response.body);
      productlists7.clear() ;
      data.forEach((element) =>
          productlists7.add(orginalteachermodel.fromJson(element)));
      data.forEach((element) =>
      teacherProfileModel = orginalteachermodel.fromJson(element));
      print(teacherProfileModel!.id);
      emit(Sucsesfavteacher());
      if(response.body == '[]'){
        emit(feuliurfavbook());
      }
      return productlists7 ;




    }catch(e){
      emit(feuliurfavbook());
      print(e);
    }







  }





  Future<void> _saveFavourite(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    if (!favorites.contains(id)) {
      favorites.add(id);
      await prefs.setStringList('favorites', favorites);
    }
  }

  Future<void> _removeFavourite(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    if (favorites.contains(id)) {
      favorites.remove(id);
      await prefs.setStringList('favorites', favorites);
    }
  }



  Future<void> _saveFavouriteteacher(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favoritesteacher') ?? [];
    if (!favorites.contains(id)) {
      favorites.add(id);
      await prefs.setStringList('favoritesteacher', favorites);
    }
  }

  Future<void> _removeFavouriteteacher(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favoritesteacher') ?? [];
    if (favorites.contains(id)) {
      favorites.remove(id);
      await prefs.setStringList('favoritesteacher', favorites);
    }
  }



}
