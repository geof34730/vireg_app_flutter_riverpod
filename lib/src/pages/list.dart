import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:Vireg/src/localization/app_localizations_context.dart';
import '../../main.dart';
import '../_class/localLang.dart';
import '../_widgets/EasySearchBar.dart';

class List extends ConsumerWidget {
  const List({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: WidgetsEasySearchBar(),
      body: Center(
        child: Column(
          children: [
            Text(ref.watch(localLangProvider)),
            ElevatedButton(
                onPressed: () => ref.read(localLangProvider.notifier).change(lang: "it"),
                child: Text('IT')
            ),
            ElevatedButton(
                onPressed: () => ref.read(localLangProvider.notifier).change(lang: "fr"),
                child: Text('FR')
            ),
            ElevatedButton(
                onPressed: () => ref.read(localLangProvider.notifier).change(lang: "rn"),
                child: Text('EN')
            ),
          ],
        ),
      ),
    );
  }

}




