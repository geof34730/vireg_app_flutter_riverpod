import 'dart:core';

import 'package:Vireg/src/localization/app_localizations_context.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:google_fonts/google_fonts.dart';

import '../_class/localstore.dart';
import '../_utils/front.dart';
import '../_widgets/boxCard.dart';
import '../_widgets/boxCardListPerso.dart';
import '../router.dart';

bool initConfig=false;

class Home extends ConsumerStatefulWidget {
  const Home({Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localstoreLocalObj=Localstorelocal(ref: ref,context: context);
    print("build Home");
      //WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!initConfig){
          localstoreLocalObj.initLang();
          initConfig=true;
        }
     // });
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
                              context.go('/share/3e9a3881-92f2-4341-b2bf-40a30c55c750');
                              },
                            child: Text('share test 3e9a3881')
                          ),
                        ElevatedButton(
                            onPressed: (){
                              context.go('/share/b72a6c67-a71d-4c2d-b67e-bc8ed28bf013');
                            },
                            child: Text('share test b72a6c67')
                        ),
                        ElevatedButton(
                            onPressed: (){
                              context.go('/share/568458ef-ff58-42fa-bcdc-34fe8a38556a');
                            },
                            child: Text('share test 568458ef')
                        ),
                        ElevatedButton(
                            onPressed: (){
                              context.go('/share/767b87d2-8b84-418b-a6aa-f7c4de480ed4');
                            },
                            child: Text('share test 767b87d2')
                        ),
                    ]
                  ),
                ]),

            Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children:[
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
            FutureBuilder<List<dynamic>>(
                future: _futureOfListPerso(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    } else if (snapshot.hasData) {
                      return Column(
                          mainAxisAlignment:MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            (snapshot.data?.length==0
                            ?
                                 SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: Padding(
                                        padding: EdgeInsets.only(
                                            top: ResponsiveContent(context: context).choseSize(mobileSize: 5.00, otherSize: 20.00),
                                            left: ResponsiveContent(context: context).choseSize(mobileSize: 15.00, otherSize: 35.00),
                                            right: ResponsiveContent(context: context).choseSize(mobileSize: 15.00, otherSize: 35.00)),
                                        child: Text(
                                          context.loc.homeDesciptionListePerso,
                                          style: TextStyle(fontSize: ResponsiveContent(context: context).choseSize(mobileSize: 14.00, otherSize: 18.00)),
                                          textAlign: TextAlign.center,
                                        )
                                  )
                                 )
                            :
                             ResponsiveGridRow(
                                children: [
                                  for (int i = 0; i < snapshot.data!.length; i++) ...[
                                    ResponsiveGridCol(
                                        xs: 12,
                                        sm:getFlexListePerso(lenghtVerbs:snapshot.data!.length,numVerb:i),
                                        md: getFlexListePerso(lenghtVerbs:snapshot.data!.length,numVerb:i),
                                        child: BoxCardListPerso(context:context,idListPerso:snapshot.data?[i])
                                    ),
                                  ],
                                ]
                             )
                            ),
                            Column(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Visibility(
                                      visible: (snapshot.data!.length>0),
                                      child:Padding(
                                        padding: EdgeInsets.only(bottom: 10.00,right: 5.0, top: ResponsiveContent(context: context).choseSize(mobileSize: 5.00, otherSize: 10.00)),
                                        child: FloatingActionButton(
                                          elevation: 10,
                                          backgroundColor: Colors.blue,
                                          onPressed: () {
                                            print('refreshAll');
                                          },
                                          child: const Icon(
                                              Icons.refresh,
                                              color: Colors.white,
                                              size:30.0
                                          ),
                                        ),
                                      )
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 10.00,left:((snapshot.data!.length>0) ? 0.0 : 5.0), top: ResponsiveContent(context: context).choseSize(mobileSize: 5.00, otherSize: 10.00)),
                                    child: FloatingActionButton(
                                      elevation: 10,
                                      backgroundColor: Colors.blue,
                                      onPressed: () {
                                        context.go("/add/ListPersoStep1");
                                      },
                                      child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size:30.0
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ])
                         ]
                      );
                    } else {
                      return const Text('Empty data');
                    }
                  } else {
                    return Text('State: ${snapshot.connectionState}');
                  }
                }),

            Divider(
              height: 10,
              thickness: 1,
              indent: ResponsiveContent(context: context).choseSize(mobileSize: 20.00, otherSize: 35.00),
              endIndent: ResponsiveContent(context: context).choseSize(mobileSize: 20.00, otherSize: 35.00),
              color: Colors.grey,
            ),
            Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
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

  int getFlexListePerso({required int lenghtVerbs,required int numVerb}) =>((lenghtVerbs==1) ? 12 : ((lenghtVerbs==numVerb+1) ? ((numVerb.isEven) ? 12 : 6 ) : 6));

}
