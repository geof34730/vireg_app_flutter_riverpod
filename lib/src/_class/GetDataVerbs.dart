import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:localstore/localstore.dart';

class GetDataVerbs  {
  final _db = Localstore.instance;

  Future<List<dynamic>> getDataJson({required String idList}) async {
      final String AllVerbsReponse = await rootBundle.loadString('assets/data/all.json');
      final List<dynamic> dataAllVerbs = await json.decode(AllVerbsReponse);
      List<dynamic> data = [];
      if(idList.contains('personalList-')){
        ///LISTE PERSO
          print("liste perso");
            for (var item in jsonDecode(AllVerbsReponse)) {
              //print(await isIdInList(idVerbs: item['id']));
              if(await isIdInList(idVerbs: item['id'],UUIDList:idList.replaceAll('personalList-', ''))) {
                  data.add(item);
              }
            }
      }
      else {
        ///LISTE PREDEFINIS
        print("liste predefinie");
        final String response = await rootBundle.loadString('assets/data/$idList.json');
        final List<dynamic> dataJsonFile = await json.decode(response);
        data = [];
        for (var element in dataAllVerbs) {
          for (var element1 in dataJsonFile) {
            if (element1['id'] == element['id']) {
                data.add(element);
            }
          }
        }
      }
      print(data);
     return data;
  }

  Future<bool> isIdInList({required int idVerbs,required UUIDList}) async {
      bool valueReturn = false;
      await _db.collection('personalLists').doc(UUIDList).get().then((value) {
        for (var item in value?['ListIdVerbs']) {
          if (item['id'].toString() == idVerbs.toString()) {
            print("$idVerbs isIdInList list existe et id existe pas dans la liste perso");
            valueReturn = true;
          }
        }
      });
    return valueReturn;
  }


}