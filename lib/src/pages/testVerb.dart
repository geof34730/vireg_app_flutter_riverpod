import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../_class/localLang.dart';
import '../router.dart';



class TestVerb extends ConsumerWidget {
  const TestVerb({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final personalListId = GoRouterState.of(context).pathParameters["personalListId"].toString();
    String localLang = ref.watch(localLangProvider);
    print('test');
    return Center(
      child: Column(
        children: [
          Text("TEST $personalListId"),
          ElevatedButton(
            onPressed: () => customRoutes.goNamed('ListPersoStep1'),
            child: const Text('Go to List perso 1'),
          ),
        ],
      ),
    );

  }
}
