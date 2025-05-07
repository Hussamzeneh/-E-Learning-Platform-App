import 'package:bloc/bloc.dart';
import 'package:untitled4/Cubit/filterbarcubit/filterbarstate.dart';

class filterbarcubit extends Cubit<filterbarstates>{
  filterbarcubit() : super(initialstate()) {

  }


int teacherselectedindex = 0 ;

int subjectselectedindex =0 ;

int Libraryselectedindex = 0 ;

  int Favouriteselectedindex = 0 ;

  teachertogeleindex({required int index}){

    if(index == 0)
{
  teacherselectedindex = 0 ;


  emit(statefilter1());

}    else if(index ==1){
      teacherselectedindex = 1 ;
       emit(statefilter2());

    }
    else{
      teacherselectedindex = 2;
       emit(statefilter3());

    }


  }
  subjecttogeleindex({required int index}){

    if(index == 0)
    {
      subjectselectedindex = 0 ;



      emit(statefilter1());

    }    else if(index ==1){
      subjectselectedindex = 1 ;

      emit(statefilter2());

    }
    else{
      subjectselectedindex = 2;

      emit(statefilter3());

    }


  }
  Favouritetogeleindex({required int index}){

    if(index == 0)
    {
      Favouriteselectedindex = 0 ;



      emit(statefilter1());

    }    else if(index ==1){
      Favouriteselectedindex = 1 ;

      emit(statefilter2());

    }


  }
  Librarytogeleindex({required int index}){

    if(index == 0)
    {
      Libraryselectedindex = 0 ;



      emit(statefilter1());

    }    else if(index ==1){
      Libraryselectedindex = 1 ;

      emit(statefilter2());

    }


  }

}