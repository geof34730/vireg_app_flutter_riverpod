import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:localstore/localstore.dart';
import '../_models/PersonalListModel.dart';
import '../router.dart';
import 'FormatData.dart';
import 'localLang.dart';





final db = Localstore.instance;


class Localstorelocal  {
  Localstorelocal({required this.context, required this.ref});

  final BuildContext context;
  final WidgetRef ref;
  final dynamic langSelect = null;

  late String langDevice=View.of(context).platformDispatcher.locale.toString().substring(0, 2);

  /////////////// BEGIN LANG /////////////////
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
  ////////// END LANG ////////////

  Future<dynamic> getJsonAllLocalStore() async {
    return db.collection('store').get().then((valueStore)  {
      return db.collection('personalList').get().then((valuePersonalList)  {
        return "[${json.encode(valueStore)},${json.encode(valuePersonalList)}]";
      });
    });
  }
  ////////////END DEV TOOLS ///////////

  ////////BEGIN  PERSONALLIST/////////////
  Future<dynamic> updateLocalstoreList({required PersonalListModel listVerbs }) async {
    savePersonalList(listVerbs: listVerbs);
    return "ok";
  }

  Future<dynamic> getJsonPersonalistLocalStore({required String idList }) async {
      return db.collection('personalList').doc(idList).get().then((valuePersonalList) async {
        return valuePersonalList;
      });
  }

  Future<dynamic> getJsonAllPersonalistLocalStore() async {
    late List ListPerso = [];
    return db.collection('store').get().then((valueStore) {
      return db.collection('personalList').get().then((valuePersonalList) {
        valuePersonalList?.entries.forEach((element) {
          ListPerso.add(
              element.value["id"]
          );
        });
        return ListPerso;
      });
    });
  }

  savePersonalList({required PersonalListModel listVerbs }){
    db.collection('personalList').doc(listVerbs.id).set(listVerbs.toJson());
  }

  createPersonalList({required String UUIDList,required String titleList, required int colorList}){
    final personalListCreate=PersonalListModel(
        id: UUIDList,
        color: colorList,
        title: titleList,
        listIdVerbs: [],
        ownListShare: true
    );
    db.collection('personalList').doc(UUIDList).set(personalListCreate.toJson());
  }

  updatePersonalList({required String UUIDList,required String titleList, required int colorList, required dynamic listIdVerbs, required bool isListShare, required bool ownListShare }){
    final personalListCreate=PersonalListModel(
        id: UUIDList,
        color: colorList,
        title: titleList,
        listIdVerbs: [],
        ownListShare:ownListShare,
        isListShare:isListShare
    );
    db.collection('personalList').doc(UUIDList).set(personalListCreate.toJson());
  }

  deletePersonalList({required String idPersonalList}){
    db.collection('personalList').doc(idPersonalList).delete();
    context.go('/');
  }
   ////////END  PERSONALLIST////////////
}



