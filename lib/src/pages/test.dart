import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../_class/localLang.dart';
import '../_class/localstore.dart';
import '../_widgets/EasySearchBar.dart';
import '../_widgets/button.dart';

class Test extends ConsumerWidget {
  const Test({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String localLang = ref.watch(localLangProvider);
    return Scaffold(
      appBar: WidgetsEasySearchBar(),
      body: Center(
        child: Column(
          children: [
            Text("Test"),
            ElevatedButton(
              onPressed: () => context.go('/learn'),
              child: const Text('Go to learn'),
            ),
          ],
        ),
      ),
    );
  }
}
