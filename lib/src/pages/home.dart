
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../_class/localLang.dart';
import '../_class/localstore.dart';

import '../_models/VerbsModel.dart';
import '../_utils/string.dart';
import '../_widgets/boxCard.dart';
import '../_widgets/button.dart';
import 'package:Vireg/src/_models/PersonalListModel.dart';


bool initConfig=true;

class Home extends ConsumerWidget {
  const Home({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String localLang = ref.watch(localLangProvider);


    if (initConfig){
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        localstorelocal(context: context, ref: ref).initLang();
        initConfig=false;
      });
    }


    return Center(
        child: Column(
          children: [
            Text("HOME"),
            BoxCard(context: context),
            BoxCard(context: context),
            BoxCard(context: context),
            BoxCard(context: context),

          ],
        ),
      );
  }
}
