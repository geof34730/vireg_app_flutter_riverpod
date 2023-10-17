import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/widgets.dart';
import 'package:localstorage/localstorage.dart';
import '../../main.dart';
import '../app.dart';
import 'localLang.dart';



class localstorelocalModel {
  String lang;
  localstorelocalModel({required this.lang});

  toJSONEncodable() {
    Map<String, dynamic> m = new Map();
    m['lang'] = lang;
    return m;
  }
}


class localstorelocal {
  localstorelocal({
    required this.context,
    required this.ref
  });

  final BuildContext context;
  final WidgetRef ref;
  final dynamic langSelect=null;

  void updateLocalstore({required String lang}) {
    storageConfig.setItem('lang', lang);
    ref.read(localLangProvider.notifier).change(lang: lang);
    print(storageConfig.getItem('lang'));



  }
  dynamic getLangLocalStore(){
    return storageConfig.getItem('lang');
  }


  String getLangDevice(){
    return View.of(this.context).platformDispatcher.locale.toString().substring(0,2);
  }


  String getLangLoad(){
   // print(storageConfig.getItem('lang'));
    if(getLangLocalStore()==null){
      //ref.read(localLangProvider.notifier).change(lang: getLangDevice());
      return getLangDevice();
  }
  else{
     // ref.read(localLangProvider.notifier).change(lang: getLangLocalStore());
      return getLangLocalStore();
    }
  }







}