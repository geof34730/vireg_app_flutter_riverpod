import 'dart:convert';
import 'dart:core';
import 'dart:async';

import 'package:Vireg/src/_class/Connectivity.dart';
import 'package:Vireg/src/router.dart';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:Vireg/src/_models/PersonalListModel.dart';
import 'package:Vireg/src/localization/app_localizations_context.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:responsive_grid/responsive_grid.dart';
import 'package:google_fonts/google_fonts.dart';


import '../_class/Loader.dart';

import '../_class/SyncroServer.dart';
import '../_class/localstore.dart';

import '../_providers/localLang.dart';
import '../_services/SharePersonalList.dart';
import '../_utils/front.dart';
import '../_utils/logger.dart';
import '../_widgets/boxCard.dart';
import '../_widgets/boxCardListPerso.dart';
import '../_widgets/dialogues.dart';



import '../../admanager_non_web_specific.dart' if (dart.library.html) 'package:admanager_web/admanager_web.dart';


import '../../admanager_non_web_specific.dart' if (dart.library.html) '../../admanager_web_specific.dart';
bool initConfig=false;

class Home extends ConsumerStatefulWidget {
  const Home({Key? key }) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  final _adRewarded = AdRewarded();
  bool _adRewardedReady = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(kIsWeb){loadRewarded();};
    });
    Logger.Green.log("init state home");
  }

  @override
  void dispose() {
    Logger.Green.log("dispose home");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Logger.Green.log("build Home");
    Logger.Blue.log((isOnline(ref: ref) ?  "online" : "offline"));
    dynamic ResponsiveContentObj=ResponsiveContent(context: context);
    dynamic DialoguesObj=Dialogues(context: context, lang:ref.watch(localLangProvider));
    if (!initConfig){
      Localstorelocal(ref: ref,context: context).initLang();
      initConfig=true;
    }

    Future<List<dynamic>> futureOfListPerso=SynchroServer(ref: ref, context: context).init();
    return Center(
      child: Column(
        children: [
          Visibility(visible: false,child: Text((isOnline(ref: ref) ?  "online" : "offline"))),
          Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                /*Padding(
                  padding:EdgeInsets.only(top:10.0),
                  child:AdBlock(
                  size: [AdBlockSize.leaderboard],
                    adUnitId: "/2247258577/Travel/Europe",
                  )),*/
                Padding(
                  padding: EdgeInsets.only(
                      top: ResponsiveContentObj.choseSize(mobileSize: 10.00, otherSize: 15.00),
                      bottom: ResponsiveContentObj.choseSize(mobileSize: 5.00, otherSize: 5.00)
                  ),
                  child: Text(
                    context.loc.homeTitlePersoList,
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: ResponsiveContentObj.choseSize(mobileSize: 20.00, otherSize: 25.00),
                          fontWeight: FontWeight.bold,
                        )),
                    textAlign: TextAlign.center,
                  ),
                )
              ]
          ),

          FutureBuilder<List<dynamic>>(
            key:UniqueKey(),
              future: futureOfListPerso,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else
                    if (snapshot.hasData) {
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
                                      top: ResponsiveContentObj.choseSize(mobileSize: 5.00, otherSize: 20.00),
                                      left: ResponsiveContentObj.choseSize(mobileSize: 15.00, otherSize: 35.00),
                                      right: ResponsiveContentObj.choseSize(mobileSize: 15.00, otherSize: 35.00)),
                                  child: Text(
                                    context.loc.homeDesciptionListePerso,
                                    style: TextStyle(fontSize: ResponsiveContentObj.choseSize(mobileSize: 14.00, otherSize: 18.00)),
                                    textAlign: TextAlign.center,
                                  )
                              )
                          )
                              :
                          ResponsiveGridRow(
                              children: [
                                for (int i = 0; i < snapshot.data!.length; i++)
                                  ...[
                                  ResponsiveGridCol(
                                      xs: 12,
                                      sm:ResponsiveContentObj.getFlexListePerso(lenghtVerbs:snapshot.data!.length,numVerb:i),
                                      md:ResponsiveContentObj.getFlexListePerso(lenghtVerbs:snapshot.data!.length,numVerb:i),
                                      child: BoxCardListPerso(
                                          context:context,
                                          personalList:personalListModelFromJson(jsonEncode(snapshot.data![i]).toString()),
                                          onClickShare: ({required String idList}) async => shareListPerso(personalList: personalListModelFromJson(jsonEncode(snapshot.data![i]).toString()),DialoguesObj:DialoguesObj) ,
                                          alerOfflineBoxCard: () async => DialoguesObj.alertOffline(),
                                          refreshState: () async => setState(() {})
                                      )
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
                                      padding: EdgeInsets.only(bottom: 10.00,right: 5.0, top: ResponsiveContentObj.choseSize(mobileSize: 5.00, otherSize: 10.00)),
                                      child: FloatingActionButton(
                                        heroTag: UniqueKey(),
                                        elevation: 10,
                                        backgroundColor: (ref.watch(connectivityStatusProviders) == ConnectivityStatus.isConnected  ? Colors.blue : Colors.grey) ,
                                        onPressed: () {
                                          (ref.watch(connectivityStatusProviders) == ConnectivityStatus.isConnected
                                              ?
                                              setState(() {})
                                              :
                                          DialoguesObj.alertOffline()
                                          );
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
                                  padding: EdgeInsets.only(bottom: 10.00,left:((snapshot.data!.length>0) ? 0.0 : 5.0), top: ResponsiveContentObj.choseSize(mobileSize: 5.00, otherSize: 10.00)),
                                  child: FloatingActionButton(
                                    heroTag: UniqueKey(),
                                    elevation: 10,
                                    backgroundColor: Colors.blue,
                                    onPressed: () async {
                                    await  FirebaseAnalytics.instance.setCurrentScreen(
                                          screenName:"button create liste perso"
                                      );
                                      customRoutesVireg.go("/add/ListPersoStep1");
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
            indent: ResponsiveContentObj.choseSize(mobileSize: 20.00, otherSize: 35.00),
            endIndent: ResponsiveContentObj.choseSize(mobileSize: 20.00, otherSize: 35.00),
            color: Colors.grey,
          ),
          Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Padding(
                  padding: EdgeInsets.only(
                      top: ResponsiveContentObj.choseSize(mobileSize: 10.00, otherSize: 15.00),
                      bottom: ResponsiveContentObj.choseSize(mobileSize: 5.00, otherSize: 5.00)
                  ),
                  child: Text(
                    context.loc.homeTitleDefaultList,
                    style: GoogleFonts.roboto(
                        textStyle: TextStyle(
                          color: Colors.black,
                          fontSize: ResponsiveContentObj.choseSize(mobileSize: 20.00, otherSize: 25.00),
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


  Future<void> shareListPerso({required PersonalListModel personalList,required dynamic DialoguesObj}) async {
    Loader(context: context, snackBar: false).showLoader();
    if(personalList.urlShare=="") {
      SharePersonalList(context: context).Share(personalList: personalList).then((value) async {
        value = await value.copyWith(isListShare: true,ownListShare: true);
        await Localstorelocal(context: context, ref: ref).updatePersonalList(PersonalList: value);
        DialoguesObj.dialogBuilderShare(personalList: value);
        setState(() {

        });
        Loader(context: context, snackBar: false).hideLoader();
      });
    }
    else{
      DialoguesObj.dialogBuilderShare(personalList: personalList);
      Loader(context: context, snackBar: false).hideLoader();
    }
  }



  void loadRewarded() {
    if (kIsWeb) {
      _adRewarded?.load(
        adUnitId: '/22639388115/rewarded_web_example',
        onAdLoaded: () =>
            setState(() {
              _adRewardedReady = true;
            }),
      );
    }
  }
}








