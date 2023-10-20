import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../_class/localLang.dart';
import '../_widgets/EasySearchBar.dart';

class ListPersoStep2 extends ConsumerWidget {
  const ListPersoStep2({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String localLang = ref.watch(localLangProvider);
    return Scaffold(
      appBar: WidgetsEasySearchBar(),
      body: Center(
        child: Column(
          children: [
            Text("List Perso Step 2"),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('Go to home'),
            ),
          ],
        ),
      ),
    );
  }
}
