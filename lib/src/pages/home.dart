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

    /*******BEGIN Manage lang*********/
    Future.delayed(Duration(milliseconds: 20), () {
      late localstorelocal localstoreLang =localstorelocal(context: context, ref: ref);
      localstoreLang.updateLocalstore(lang: localstoreLang.getLangLoad());
    });
    String localLang=ref.watch(localLangProvider);
    /*******BEGIN Manage lang*********/


    return Scaffold(
      appBar: WidgetsEasySearchBar(),
      body: Center(
        child: Column(
          children: [
            Text("lang provider: $localLang"),
            Text("lang device: ${View.of(context).platformDispatcher.locale.toString().substring(0,2)}"),
            Text("lang localstore: ${localstorelocal(context: context, ref: ref).getLangLoad()}"),


            ElevatedButton(
                style:getButtonStyle(lang: "de",localLang: localLang),
                onPressed: () => localstorelocal(context: context, ref: ref).updateLocalstore(lang: "de"),
                child: Text('DE')
            ),
            ElevatedButton(
                style:getButtonStyle(lang: "it",localLang: localLang),
                onPressed: () => localstorelocal(context: context, ref: ref).updateLocalstore(lang: "it"),
                child: Text('IT')
            ),
            ElevatedButton(
                style:getButtonStyle(lang: "fr",localLang: localLang),
                onPressed: () => localstorelocal(context: context, ref: ref).updateLocalstore(lang: "fr"),
                child: Text('FR')
            ),
            ElevatedButton(
                style:getButtonStyle(lang: "en",localLang: localLang),
                onPressed: () => localstorelocal(context: context, ref: ref).updateLocalstore(lang: "en"),
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





