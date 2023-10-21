import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../_class/localLang.dart';


class Learn extends ConsumerWidget {
  const Learn({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {



    final personalListId = GoRouterState.of(context).pathParameters["personalListId"];
    String localLang = ref.watch(localLangProvider);
    return Center(
        child: Column(
          children: [
            Text("LEARN $personalListId"),
            ElevatedButton(
              onPressed: () => context.go('/ListPersoStep1'),
              child: const Text('Go to List perso 1'),
            ),
          ],
        ),
      );

  }
}
