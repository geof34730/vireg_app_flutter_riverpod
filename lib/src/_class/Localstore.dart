import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:localstorage/localstorage.dart';
import '../_models/PersonalListModel.dart';
import 'localLang.dart';





final LocalStorage storageConfig = new LocalStorage('config');
class Localstorelocal {
  Localstorelocal({required this.context, required this.ref});

  final BuildContext context;
  final WidgetRef ref;
  final dynamic langSelect = null;


  /////* BEGIN LANG*///////
  dynamic listLangSupported() => context.findAncestorWidgetOfExactType<MaterialApp>()?.supportedLocales;

  String getLangDevice() => View.of(this.context).platformDispatcher.locale.toString().substring(0, 2);

  String getLangLoad(){
   if(this.getLangLocalStore() == null){
      return this.getLangDevice();
    }
    else{
      return this.getLangLocalStore();
    }
  }

  dynamic getLangLocalStore() => LocalStorage('config').getItem("lang");

  void updateLocalstoreLang({required String lang, bool withChange = true}) {
    storageConfig.setItem('lang', lang);
    ref.read(localLangProvider.notifier).change(lang: lang);
  }

  void initLang() async  {
     await storageConfig.ready;
      print('init lang');
      updateLocalstoreLang(lang: getLangLoad(), withChange: true);
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




  Future<dynamic> updateLocalstoreList({required PersonalListModel listVerbs }) async {
    print(listVerbs);
    return "ok";
  }



}
