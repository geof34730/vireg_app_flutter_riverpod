import 'dart:core';

import 'package:Vireg/src/localization/app_localizations_context.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:google_fonts/google_fonts.dart';

import '../_class/localstore.dart';
import '../_utils/front.dart';
import '../_widgets/boxCard.dart';
import '../_widgets/boxCardListPerso.dart';
import '../router.dart';

bool initConfig=true;

class Home extends ConsumerWidget {
  Home({super.key});
  final FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final localstoreLocalObj=Localstorelocal(ref: ref,context: context);
    print("build Home");
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (initConfig){
          localstoreLocalObj.initLang();
          initConfig=false;
        }
      });
    Future<List<dynamic>> _futureOfListPerso() => localstoreLocalObj.getJsonAllPersonalistLocalStore().then((value) =>value);
    return Center(
        child: Column(
          children: [
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                      children:[
                        ElevatedButton(
                            onPressed: (){
                              customRoutes.go('/share/3e9a3881-92f2-4341-b2bf-40a30c55c750');
                              },
                            child: Text('share test 3e9a3881')
                          ),
                          ElevatedButton(
                            onPressed: (){
                              customRoutes.go('/share/b72a6c67-a71d-4c2d-b67e-bc8ed28bf013');
                            },
                            child: Text('share test b72a6c67')
                          ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: ResponsiveContent(context: context).choseSize(mobileSize: 10.00, otherSize: 15.00),
                              bottom: ResponsiveContent(context: context).choseSize(mobileSize: 5.00, otherSize: 5.00)
                          ),
                          child: Text(
                            context.loc.homeTitlePersoList,
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  color: Colors.black,
                                  fontSize: ResponsiveContent(context: context).choseSize(mobileSize: 20.00, otherSize: 25.00),
                                  fontWeight: FontWeight.bold,
                                )),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ]
                  ),
                ]),



            FutureBuilder<List<dynamic>>(
                future: _futureOfListPerso(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      print(snapshot.data?.length);
                      //return const Text('ok data');
                      return ResponsiveGridRow(
                          children: [
                            for (int i = 0; i < snapshot.data!.length; i++) ...[
                              ResponsiveGridCol(
                                  xs: 12,
                                  sm:6,
                                  md: 6,
                                  child: BoxCardListPerso(context:context,idListPerso:snapshot.data?[i])
                              ),
                            ],
                          ]
                      );
                    } else {
                      return const Text('Empty data');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                }),
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                      children:[
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
                      ]
                  ),
            ]),
            ResponsiveGridRow(
                    children: [
                      ResponsiveGridCol(
                        xs: 12,
                        sm:6,
                        md: 6,
                        child: BoxCard(context: context,colorsList: Colors.green,titleList:"Top 20",idListPerso:"top20"),
                      ),
                      ResponsiveGridCol(
                        xs: 12,
                        sm:6,
                        md: 6,
                        child: BoxCard(context: context,colorsList: Colors.blue,titleList:"Top 50",idListPerso:"top50"),
                      ),
                      ResponsiveGridCol(
                        xs: 12,
                        sm:6,
                        md: 6,
                        child: BoxCard(context: context,colorsList: Colors.orange,titleList:"Top 100",idListPerso:"top100"),
                      ),
                      ResponsiveGridCol(
                        xs: 12,
                        sm:6,
                        md: 6,
                        child: BoxCard(context: context,colorsList: Colors.red,titleList:"Top 200",idListPerso:"top200"),
                      ),
                  ]
                )
         ],
        ),
      );
  }
}
