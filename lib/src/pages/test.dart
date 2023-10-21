import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../_class/localLang.dart';


class Test extends ConsumerWidget {
  const Test({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String localLang = ref.watch(localLangProvider);
    return Center(
        child: Column(
          children: [
            Text("Test"),
            ElevatedButton(
              onPressed: () => context.go('/learn'),
              child: const Text('Go to learn'),
            ),
          ],
        ),
      );
  }
}
