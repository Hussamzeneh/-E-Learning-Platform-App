import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:untitled4/Cubit/Subject%20cubit/subjectdetailsstates.dart';

import 'package:untitled4/Model/unitmodel.dart';
import 'package:http/http.dart' as http;
import 'package:untitled4/Screen/SubjectPage.dart';

import '../../constans.dart';

class subjectdetailscubit extends Cubit<subjectdetailsstate> {
  subjectdetailscubit() : super(initialstatedetails()) {

  }

  unitmodel? Unitmoedl;
  Set<unitmodel> unitlist = {};

  Future<Set<unitmodel>?> getsubjectdetails({required int id}) async {
    emit(loading());

    http.Response response = await http.post(
        Uri.parse('http://${KURL}:8000/api/show_subject'),
        body: {'subject_id': id.toString()});

    var data = jsonDecode(response.body);

    try {
      unitlist.clear();
      data['units']
          .forEach((element) => unitlist.add(unitmodel.fromJson(element)));

      data['units']
          .forEach((element) => Unitmoedl = unitmodel.fromJson(element));
      print(unitlist);

      print(Unitmoedl);
      print(Unitmoedl!.descrebtion);
      emit(initialstatedetails());
      return unitlist;
    } catch (e) {
      print(e);
      emit(feleuir());
    }
  }
}
