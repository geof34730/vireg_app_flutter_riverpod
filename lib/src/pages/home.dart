import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../main.dart';
import '../_class/localLang.dart';
import '../_class/localstore.dart';
import '../_widgets/EasySearchBar.dart';


class Home extends ConsumerWidget  {
  const Home({super.key});



  @override
  Widget build(BuildContext context, WidgetRef ref) {

    String localLang=ref.watch(localLangProvider);
    return Scaffold(
      appBar: WidgetsEasySearchBar(),
      body: Center(
        child: Column(
          children: [
            Text(localLang),
            Text(View.of(context).platformDispatcher.locale.toString().substring(0,2)),
            ElevatedButton(
                style:getButtonStyle(lang: "de",localLang: localLang),
                onPressed: () => ref.read(localLangProvider.notifier).change(lang: "de"),
                child: Text('DE')
            ),
            ElevatedButton(
                style:getButtonStyle(lang: "it",localLang: localLang),
                onPressed: () => ref.read(localLangProvider.notifier).change(lang: "it"),
                child: Text('IT')
            ),
            ElevatedButton(
                style:getButtonStyle(lang: "fr",localLang: localLang),
                onPressed: () => ref.read(localLangProvider.notifier).change(lang: "fr"),
                child: Text('FR')
            ),
            ElevatedButton(
                style:getButtonStyle(lang: "en",localLang: localLang),
                onPressed: () => ref.read(localLangProvider.notifier).change(lang: "en"),
                child: Text('EN')
            ),
          ],
        ),
      ),
    );
  }

}

ButtonStyle getButtonStyle({required String lang,required String localLang}){
  return ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>((localLang == lang ? Colors.green : Colors.blue))
  );
}





