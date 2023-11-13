import 'package:Vireg/src/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



class ListPersoStep1 extends ConsumerWidget {
  const ListPersoStep1({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("build listperso 1");
    return Center(
      child: Column(
        children: [
          Text("Liste perso 1"),
          ElevatedButton(
            onPressed: () => customRoutes.goNamed('ListPersoStep2'),


            child: const Text('Go to List Perso Step 2'),
          ),
        ],
      ),
    );

  }
}
