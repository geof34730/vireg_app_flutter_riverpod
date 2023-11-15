import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localstore/localstore.dart';
import '../_models/PersonalListModel.dart';
import 'localLang.dart';





final db = Localstore.instance;


class Localstorelocal {
  Localstorelocal({required this.context, required this.ref});

  final BuildContext context;
  final WidgetRef ref;
  final dynamic langSelect = null;

  late String langDevice=View.of(context).platformDispatcher.locale.toString().substring(0, 2);

  /////* BEGIN LANG*///////
  dynamic listLangSupported() => context.findAncestorWidgetOfExactType<MaterialApp>()?.supportedLocales;

  dynamic getLangLoad() {
     if(getLangLocalStore() == null){
        return langDevice;
      }
      else{
        return getLangLocalStore();
      }
    }

    dynamic getLangLocalStore()  {
      db.collection('store').doc("config").get().then((value) {
        return value?["lang"].toString();
      });
    }

    void updateLocalstoreLang({required String lang, bool withChange = true}) {
      db.collection('store').doc("config").set({'lang':lang});
      db.collection('store').doc("PersonalList").set({'id':"dsfsdfsdf","title":"dddddd"});
      db.collection('store').doc("PersonalList").set({'id':"dsfsdfsdf","title":"dddddd"});


      ref.read(localLangProvider.notifier).change(lang: lang);
    }

    void initLang() {
      print('Init lang ${getLangLoad()}');
      updateLocalstoreLang(lang: getLangLoad(), withChange: true);


      //getJsonAllLocalStore();

    }

    int getItemLangSelect(){
      int numItemLang = 0;
      int numItemLangSelect = 0;
      for (var langs in this.listLangSupported()) {
        if (langs.toString() == ref.watch(localLangProvider).toString()) {
          numItemLangSelect = numItemLang;
          break;
        }
        numItemLang++;
      }
      return numItemLangSelect;
    }
    ///* END LANG */////



    /////BEGIN COMMON//////
    Future<dynamic> getJsonAllLocalStore() async {
     return  db.collection('store').get().then((value) => json.encode(value));
    }
    ////END COMMON////

    Future<dynamic> updateLocalstoreList({required PersonalListModel listVerbs }) async {
      print(listVerbs);
      return "ok";
    }

}



