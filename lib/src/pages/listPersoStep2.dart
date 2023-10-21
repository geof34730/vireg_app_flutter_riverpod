import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../_class/localLang.dart';
import '../_class/localstore.dart';
import '../_class/router.dart';
import '../_widgets/button.dart';


class ListPersoStep2 extends ConsumerWidget {
  const ListPersoStep2({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String localLang = ref.watch(localLangProvider);
    return Center(
      child: Column(
        children: [
          Text("Liste perso 2"),
          Text("Router path: ${ref.watch(routerProvider)}"),
          Text("lang provider: $localLang"),
          Text("lang device: ${View.of(context).platformDispatcher.locale.toString().substring(0, 2)}"),
          Text("lang localstore: ${localstorelocal(context: context, ref: ref).getLangLoad()}"),
          ElevatedButton(
              style: getButtonStyleLang(lang: "de", localLang: localLang),
              onPressed: () => localstorelocal(context: context, ref: ref).updateLocalstore(lang: "de"),
              child: Text('DE')),
          ElevatedButton(
              style: getButtonStyleLang(lang: "it", localLang: localLang),
              onPressed: () => localstorelocal(context: context, ref: ref).updateLocalstore(lang: "it"),
              child: Text('IT')),
          ElevatedButton(
              style: getButtonStyleLang(lang: "fr", localLang: localLang),
              onPressed: () => localstorelocal(context: context, ref: ref).updateLocalstore(lang: "fr"),
              child: Text('FR')),
          ElevatedButton(
              style: getButtonStyleLang(lang: "en", localLang: localLang),
              onPressed: () => localstorelocal(context: context, ref: ref).updateLocalstore(lang: "en"),
              child: Text('EN')),
          ElevatedButton(
              style: getButtonStyleLang(lang: "ru", localLang: localLang),
              onPressed: () => localstorelocal(context: context, ref: ref).updateLocalstore(lang: "ru"),
              child: Text('RU')),
          ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text('back HOME'),
          ),
        ],
      ),
    );

  }
}
