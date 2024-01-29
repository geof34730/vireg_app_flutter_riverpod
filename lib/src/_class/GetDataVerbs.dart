import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:localstore/localstore.dart';

class GetDataVerbs  {
  final db = Localstore.instance;

  Future<List<dynamic>> getDataJson({required String idList, bool personalList = false}) async {
      final String AllVerbsReponse = await rootBundle.loadString('assets/data/all.json');
      final List<dynamic> dataAllVerbs = await json.decode(AllVerbsReponse);
      List<dynamic> data = [];
      if(personalList){
        ///LISTE PERSO
          print("liste perso");
            for (var item in jsonDecode(AllVerbsReponse)) {
                if (await isIdInList(idVerbs: item['id'],idList: idList)) {
                  print(item['id']);
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
     return data;
  }

  Future<bool> isIdInList({required int idVerbs,required String idList}) async {
      bool valueReturn = false;
      await db.collection('personalList').doc(idList).get().then((value)  {
        for (var itemVerb in value?['ListIdVerbs']) {
          try {
            if (itemVerb.id.toString() == idVerbs.toString()) {
              valueReturn = true;
            }
          } catch(e) {
            if (itemVerb["id"].toString() == idVerbs.toString()) {
              valueReturn = true;
            }
          }
        }
      });
      return valueReturn;
  }
}