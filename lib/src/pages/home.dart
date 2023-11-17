import 'package:Vireg/src/localization/app_localizations_context.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:google_fonts/google_fonts.dart';

import '../_class/localstore.dart';
import '../_utils/front.dart';
import '../_widgets/boxCard.dart';

bool initConfig=true;

class Home extends ConsumerWidget {
  Home({super.key});
  final FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    print("build Home");
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (initConfig){
          Localstorelocal(context: context, ref: ref).initLang();
          initConfig=false;
        }
      });

    return Center(
        child: Column(
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: EdgeInsets.only(
                    top: ResponsiveContent(context: context).choseSize(mobileSize: 10.00, otherSize: 15.00),
                    bottom: ResponsiveContent(context: context).choseSize(mobileSize: 5.00, otherSize: 5.00)
                ),
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
                        sm:6,
                        md: 6,
                        child: BoxCard(context: context,colorsList: Colors.green,titleList:context.loc.homeBoxCardTop20,idListPerso:"top20",nbVerbsPerso: 20,),
                      ),
                      ResponsiveGridCol(
                        xs: 12,
                        sm:6,
                        md: 6,
                        child: BoxCard(context: context,colorsList: Colors.blue,titleList:context.loc.homeBoxCardTop50,idListPerso:"top50",nbVerbsPerso: 50),
                      ),
                      ResponsiveGridCol(
                        xs: 12,
                        sm:6,
                        md: 6,
                        child: BoxCard(context: context,colorsList: Colors.orange,titleList:context.loc.homeBoxCardTop100,idListPerso:"top100",nbVerbsPerso: 100),
                      ),
                      ResponsiveGridCol(
                        xs: 12,
                        sm:6,
                        md: 6,
                        child: BoxCard(context: context,colorsList: Colors.red,titleList:context.loc.homeBoxCardTop200,idListPerso:"top200",nbVerbsPerso: 200),
                      ),
                  ]
                )
         ],
        ),
      );
  }
}
