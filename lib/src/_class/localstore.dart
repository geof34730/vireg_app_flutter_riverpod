import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/widgets.dart';

import 'localLang.dart';

class localstorelocal {
  localstorelocal({
    required this.context,
    required this.ref
  });

  final BuildContext context;
  final WidgetRef ref;
  final String langSelect="fr";

  void updateLocalstore({required String lang}) {
    ref.read(localLangProvider.notifier).change(lang: lang);
  }



   String getLangLoad(){
    if(getLangLocalStore()==null){
      ref.read(localLangProvider.notifier).change(lang: getLangDevice());
      return getLangDevice();

    }
    else{
      ref.read(localLangProvider.notifier).change(lang: getLangLocalStore());
      return getLangLocalStore();
    }
  }

  dynamic getLangLocalStore(){
    return langSelect;
  }

  String getLangDevice(){
    return View.of(this.context).platformDispatcher.locale.toString().substring(0,2);
  }



}