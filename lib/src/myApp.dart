import 'package:Vireg/src/_utils/theme.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '_class/DeepLink.dart';

import '_providers/localLang.dart';


import 'router.dart';

late dynamic objDeeplinksInit=null;

class MyApp extends ConsumerWidget {
  final PendingDynamicLinkData? initialLink;
  const MyApp({this.initialLink, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if(objDeeplinksInit==null){
        final objDeeplinksInit=DeepLink(context:context,ref:ref);
        objDeeplinksInit.initDeepLinks(initialLink:initialLink);
      }
      else{
        print("rebuild myapp");
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
