import 'package:Vireg/src/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../_class/localLang.dart';


class LearnVerb extends ConsumerWidget {
  const LearnVerb({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('learn');
    return Center(
        child: Column(
          children: [
           Text("LEARN"),
            ElevatedButton(
              onPressed: () => customRoutes.goNamed('ListPersoStep1'),
              child: const Text('Go to List perso 1'),
            ),
          ],
        ),
      );

  }
}
