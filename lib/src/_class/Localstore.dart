import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:localstore/localstore.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../_models/PersonalListModel.dart';

import '../_services/SharePersonalList.dart';

import '../_providers/localLang.dart';
import '../../global.dart' as globals;
import '../_utils/logger.dart';
import '../router.dart';

final db = Localstore.instance;

class Localstorelocal  {
  Localstorelocal({required this.context, required this.ref});
  final BuildContext context;
  final WidgetRef ref;
  final String langSelect = "";
  late String langDevice=View.of(context).platformDispatcher.locale.toString().substring(0, 2);

  /////////////// BEGIN LANG /////////////////
  dynamic listLangSupported() => context.findAncestorWidgetOfExactType<MaterialApp>()?.supportedLocales;

  dynamic getLangLoad() async =>(await getLangLocalStore() == "" ? langDevice : getLangLocalStore());

  Future<String> getLangLocalStore() async => await db.collection('store').doc("config").get().then((value) => ((value!=null && value["lang"]!=null) ? value["lang"].toString() : ""));

  void updateLocalstoreLang({required String lang}) async {
      db.collection('store').doc("config").set({'lang': lang, 'versionApp': globals.versionApp});
      ref.read(localLangProvider.notifier).change(lang: lang);
  }

  void initLang() async {
    String langApp=await getLangLoad();
    Logger.Green.log('Init lang =>  $langApp');
    updateLocalstoreLang(lang: langApp);
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

  ////////////BEGIN DEV TOOLS ///////////
  Future<dynamic> getJsonAllLocalStore() async => await db.collection('store').get().then((valueStore) async => await db.collection('personalList').get().then((valuePersonalList) async => "[${json.encode(valueStore)},${json.encode(valuePersonalList)}]"));
  ////////////END DEV TOOLS ///////////

  ////////BEGIN  PERSONALLIST/////////////
  Future<dynamic> updateLocalstoreList({required PersonalListModel PersonalList }) async =>(savePersonalList(PersonalList: PersonalList),"ok");

  Future<PersonalListModel> getJsonPersonalistLocalStore({required String idList }) async {
    return  db.collection('personalList').doc(idList).get().then((value) {
        return personalListModelFromJson(jsonEncode(value));
    });
  }

  Future<List<dynamic>> getJsonAllPersonalistLocalStore() async {
    late List<dynamic> ListPerso = [];
    return await db.collection('store').get().then((valueStore) async {
      return await db.collection('personalList').get().then((valuePersonalList) async {
         valuePersonalList?.entries.forEach((element)  {
          ListPerso.add(element.value);
        });
        return ListPerso;
      });
    });
  }

  savePersonalList({required PersonalListModel PersonalList }){
    db.collection('personalList').doc(PersonalList.id).set(PersonalList.toJson());
  }

  createPersonalList({required PersonalListModel PersonalList}){
    db.collection('personalList').doc(PersonalList.id).set(PersonalList.toJson());
  }

  updatePersonalList({required PersonalListModel PersonalList }){
    Logger.Green.log("updatePersonalList");
    if(PersonalList.isListShare && PersonalList.ownListShare){
      Logger.Green.log("update serveur");
    }
    Logger.Green.log(PersonalList);
    db.collection('personalList').doc(PersonalList.id).set(PersonalList.toJson());
  }

  Future<String> deletePersonalList({required PersonalListModel personalList}) async{
    Logger.Green.log("personalList.ownListShare: ${personalList.ownListShare}");
    if(personalList.ownListShare){
      await SharePersonalList(context:context).DeleteList(personalList: personalList).then((value) => db.collection('personalList').doc(personalList.id).delete());
    }
    else{
     await  db.collection('personalList').doc(personalList.id).delete();
    }

    return "ok";
  }
   ////////END  PERSONALLIST////////////
}



