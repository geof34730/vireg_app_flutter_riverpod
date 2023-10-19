import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../main.dart';
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
  localstorelocal({required this.context, required this.ref});

  final BuildContext context;
  final WidgetRef ref;
  final dynamic langSelect = null;

  void updateLocalstore({required String lang, bool withChange = true}) {
    storageConfig.setItem('lang', lang);
    var currentRoute =
        GoRouter.of(context).routeInformationProvider.value.uri.toString();
    ref.read(localLangProvider.notifier).change(lang: lang);
/*
    if (currentRoute != "/" && withChange) {
      Future.delayed(Duration(milliseconds: 500), () {
        print(currentRoute);
        context.go(currentRoute);
      });
    }
    */
  }

  dynamic getLangLocalStore() => storageConfig.getItem('lang');

  String getLangDevice() => View.of(this.context)
      .platformDispatcher
      .locale
      .toString()
      .substring(0, 2);

  String getLangLoad() =>
      (getLangLocalStore() == null ? getLangDevice() : getLangLocalStore());
}
