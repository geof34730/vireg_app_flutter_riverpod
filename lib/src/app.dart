import 'package:Vireg/src/_utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../main.dart';
import '_class/localLang.dart';
import '_class/localstore.dart';
import 'localization/app_localizations_context.dart';
import 'pages/home.dart';


class MyApp extends ConsumerWidget{
   MyApp({super.key});






  @override
  Widget build(BuildContext context, WidgetRef ref)   {
    return MaterialApp(
      locale: Locale(ref.watch(localLangProvider)),
      theme:getThemeData(),
      restorationScopeId: 'app',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
     // onGenerateTitle: (BuildContext context) => "Vireg",
      //context.loc.appTitle,
      home: Home(),
    );
  }

}
