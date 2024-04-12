import 'dart:async';

import 'package:Vireg/src/_utils/theme.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Vireg/src/_class/Connectivity.dart';
import '_class/Connectivity.dart';
import '_class/DeepLink.dart';

import '_class/SnackBar.dart';
import '_providers/localLang.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '_utils/logger.dart';
import 'router.dart';

late dynamic objDeeplinksInit=null;

class MyApp extends ConsumerWidget {
  final PendingDynamicLinkData? initialLink;
  const MyApp({this.initialLink, Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if(objDeeplinksInit==null){
        Logger.Green.log("NO DEEPLINK myapp");
        objDeeplinksInit=DeepLink(context:context,ref:ref);
        objDeeplinksInit.initDeepLinks(initialLink:initialLink);
      }
      else{
        Logger.Green.log("DEEPLINK myapp");
      }
    });

    return MaterialApp.router(

      theme: getThemeData(),
      routerConfig: customRoutesVireg,
      locale: Locale(ref.watch(localLangProvider)),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
    );
  }
}

