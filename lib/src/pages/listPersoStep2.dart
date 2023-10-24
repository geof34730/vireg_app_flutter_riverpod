import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../_class/localLang.dart';
import '../_class/localstore.dart';

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
          Text("lang provider: $localLang"),
          Text("lang device: ${View.of(context).platformDispatcher.locale.toString().substring(0, 2)}"),
          Text("lang localstore: ${localstorelocal(context: context, ref: ref).getLangLoad()}"),
          ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text('back HOME'),
          ),
        ],
      ),
    );

  }
}
