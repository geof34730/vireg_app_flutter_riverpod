
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../_class/localLang.dart';
import '../_class/localstore.dart';

import '../_models/VerbsModel.dart';
import '../_widgets/button.dart';
import 'package:Vireg/src/_models/PersonalListModel.dart';


bool initConfig=true;

class Home extends ConsumerWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String localLang = ref.watch(localLangProvider);

    if (initConfig){
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        localstorelocal(context: context, ref: ref).initLang();
        initConfig=false;
      });
    }


    return Center(
        child: Column(
          children: [
            Text("HOME"),
            Text("lang provider: $localLang"),
            Text("lang device: ${View.of(context).platformDispatcher.locale.toString().substring(0, 2)}"),
            Text("lang localstore: ${localstorelocal(context: context, ref: ref).getLangLoad()}"),
            ElevatedButton(
              onPressed: () => context.go('/ListPersoStep1'),
              child: const Text('Go to liste perso 1'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/LearnVerb/5555'),
              child: const Text('LEARN'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/TestVerb/5555'),
              child: const Text('TEST'),
            ),
            ElevatedButton(
              onPressed: () => context.go('/ListVerb/5555'),
              child: const Text('LIST'),
            ),
          ],
        ),
      );
  }
}
