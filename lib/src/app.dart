import 'package:Vireg/src/_utils/theme.dart';
import 'package:firebase_dynamic_links_platform_interface/src/pending_dynamic_link_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '_class/localLang.dart';
import 'router.dart';


class MyApp extends ConsumerWidget {
  final PendingDynamicLinkData? initialLink;
  const MyApp({this.initialLink, Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print(initialLink);

      print('ddddd');
      if (initialLink != null) {
        // Example of using the dynamic link to push the user to a different screen
        prssint("************REDIRECT LOAD WIDTH PARAM DEEP LINK<> ${initialLink?.link.path}");
        print("route GO");
        //_router.go(initialLink!.link.path);
        print("route OK");


        print("route EN");
      }

    return MaterialApp.router(
        theme: getThemeData(),
        routerConfig: customRoutes,
        locale: Locale(ref.watch(localLangProvider)),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
    );
  }
}

