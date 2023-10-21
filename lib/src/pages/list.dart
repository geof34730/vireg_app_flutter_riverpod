import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../_class/localLang.dart';


class List extends ConsumerWidget {
  const List({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String localLang = ref.watch(localLangProvider);
    return Center(
        child: Column(
          children: [
            Text("List"),
            ElevatedButton(
              onPressed: () => context.go('/home'),
              child: const Text('Go to home'),
            ),
          ],
        ),
      );
  }
}
