import 'package:Vireg/src/_class/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:localstorage/localstorage.dart';
import '../_models/LocalstoreModel.dart';

import 'localLang.dart';



bool beforeInitLang=true;

class localstorelocal {
  localstorelocal({required this.context, required this.ref});

  final BuildContext context;
  final WidgetRef ref;
  final dynamic langSelect = null;
  final LocalStorage storageConfig = new LocalStorage('config');
  dynamic listLangSupported() => context.findAncestorWidgetOfExactType<MaterialApp>()?.supportedLocales;
  String getLangDevice() => View.of(this.context).platformDispatcher.locale.toString().substring(0, 2);
  String getLangLoad() => (this.getLangLocalStore() == null ? this.getLangDevice() : this.getLangLocalStore());
  dynamic getLangLocalStore() => LocalStorage('config').getItem("lang");

  void updateLocalstore({required String lang, bool withChange = true}) {
    storageConfig.setItem('lang', lang);
    if(withChange) {
      var currentRoute = GoRouter.of(context).routeInformationProvider.value.uri.toString();
      ref.read(routerProvider.notifier).change(path: currentRoute);
      ref.read(localLangProvider.notifier).change(lang: lang);
    }
  }

  void initLang() {
    if(beforeInitLang) {
      beforeInitLang=false;
      Future.delayed(Duration(milliseconds: 100), () {
        updateLocalstore(lang: getLangLoad(), withChange: true);
      });
    }
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

}
