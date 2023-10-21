import 'package:Vireg/src/_utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '_widgets/EasySearchBar.dart';
import '_class/localLang.dart';
import '_class/router.dart';


class MyApp extends ConsumerWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
        theme: getThemeData(),
        routerConfig: viregrouter(ref: ref).getRouter(),
        locale: Locale(ref.watch(localLangProvider)),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,

    );
  }
}

