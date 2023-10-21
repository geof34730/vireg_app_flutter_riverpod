import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../_class/localLang.dart';


class ListPersoStep1 extends ConsumerWidget {
  const ListPersoStep1({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String localLang = ref.watch(localLangProvider);
    return  Center(
        child: Column(
          children: [
            Text("List Perso Step 1"),
            ElevatedButton(
              onPressed: () => context.go('/ListPersoStep1/ListPersoStep2'),
              child: const Text('Go List perso step 2'),
            ),
          ],
        ),
    );
  }
}
