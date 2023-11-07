import 'package:Vireg/src/_utils/theme.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '_class/localLang.dart';
import 'router.dart';

class MyApp extends ConsumerWidget {
  final PendingDynamicLinkData? initialLink;
  const MyApp({this.initialLink, Key? key}) : super(key: key);

  static void initDeepLinks() {
    FirebaseDynamicLinks.instance.onLink.listen((deepLinkData) {
      final deepLink = deepLinkData.link;
      print('Link received: $deepLink');
      customRoutes.go(deepLink.path);
    }).onError((error) {
      print('onLink error:');
      print(error.message);
    });
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
        initDeepLinks();
    });
    print('initialLink => $initialLink');
    if (initialLink != null) {
      print("************REDIRECT LOAD WITH PARAM DEEP LINK => ${initialLink?.link.path}");
      customRoutes.go(initialLink!.link.path);
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
