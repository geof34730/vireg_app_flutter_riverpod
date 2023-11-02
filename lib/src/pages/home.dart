
import 'package:Vireg/src/localization/app_localizations_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../_class/localLang.dart';
import '../_class/localstore.dart';

import '../_models/VerbsModel.dart';
import '../_utils/front.dart';
import '../_utils/string.dart';
import '../_widgets/boxCard.dart';
import '../_widgets/button.dart';
import 'package:Vireg/src/_models/PersonalListModel.dart';
import 'package:responsive_grid/responsive_grid.dart';

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

            Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: EdgeInsets.only(
                    top: ResponsiveContent(context: context).choseSize(mobileSize: 10.00, otherSize: 15.00),
                    bottom: ResponsiveContent(context: context).choseSize(mobileSize: 5.00, otherSize: 5.00)),
                child: Text(
                  context.loc.homeTitleDefaultList,
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: ResponsiveContent(context: context).choseSize(mobileSize: 20.00, otherSize: 25.00),
                        fontWeight: FontWeight.bold,
                      )),
                  textAlign: TextAlign.center,
                ),
              )
            ]),



            ResponsiveGridRow(
                    children: [
                      ResponsiveGridCol(
                        xs: 12,
                        md: 6,
                          child: BoxCard(context: context,colorsList: Colors.green,titleList:context.loc.homeBoxCardTop20),
                      ),
                      ResponsiveGridCol(
                        xs: 12,
                        md: 6,
                          child: BoxCard(context: context,colorsList: Colors.blue,titleList:context.loc.homeBoxCardTop50),
                      ),
                      ResponsiveGridCol(
                        xs: 12,
                        md: 6,
                          child: BoxCard(context: context,colorsList: Colors.orange,titleList:context.loc.homeBoxCardTop100),
                      ),
                      ResponsiveGridCol(
                        xs: 12,
                        md: 6,
                          child: BoxCard(context: context,colorsList: Colors.red,titleList:context.loc.homeBoxCardTop200),
                      ),
                  ]
                )

         ],
        ),
      );
  }
}
