import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localstore/localstore.dart';
import '../_models/PersonalListModel.dart';
import 'localLang.dart';





final db = Localstore.instance;


class Localstorelocal  {
  Localstorelocal({required this.context, required this.ref});

  final BuildContext context;
  final WidgetRef ref;
  final dynamic langSelect = null;

  late String langDevice=View.of(context).platformDispatcher.locale.toString().substring(0, 2);

  ///////////////* BEGIN LANG*/////////////////
  dynamic listLangSupported() => context.findAncestorWidgetOfExactType<MaterialApp>()?.supportedLocales;

  dynamic getLangLoad() async {

    if(getLangLocalStore() == null){
        return langDevice;
      }
      else{
        return getLangLocalStore();
      }
    }

    dynamic getLangLocalStore() async  {
      return  db.collection('store').doc("config").get().then((value)  => value?["lang"].toString());
    }

    void updateLocalstoreLang({required String lang, bool withChange = true}) {
      db.collection('store').doc("config").set({'lang':lang});
      db.collection('personalList').doc("8888").set({'id':"8888","title":"dddddd"});
      db.collection('personalList').doc("85").set({'id':"85","title":"dddddd"});
      db.collection('personalList').doc("64").set({'id':"64","title":"dddddd"});

      ref.read(localLangProvider.notifier).change(lang: lang);
    }

    void initLang() async {


      String langApp=await getLangLoad();
      print('Init lang =>  $langApp');
      updateLocalstoreLang(lang: await langApp, withChange: true);
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

    /////BEGIN DEV TOOLS//////
    Future<dynamic> getJsonAllLocalStore() async {
      return db.collection('store').get().then((valueStore)  {
        return db.collection('personalList').get().then((valuePersonalList)  {
          return "[${json.encode(valueStore)},${json.encode(valuePersonalList)}]";
        });
      });
    }
    ////END DEV TOOLS////

    ////////BEGIN  PERSONALLIST////////////
    Future<dynamic> updateLocalstoreList({required PersonalListModel listVerbs }) async {
      print(listVerbs);
      return "ok";
    }

    getContentPersonalList({required String idPersonalList}) async{
      return db.collection('personalList').doc(idPersonalList).get().then((value) => value);
    }

    savePersonalList({required PersonalListModel listVerbs }){

    }

    deletePersonalList({required String idPersonalList}){

    }
     ////////END  PERSONALLIST////////////


}



