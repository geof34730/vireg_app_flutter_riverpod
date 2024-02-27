import 'dart:convert';
import 'dart:core';
import 'dart:async';
import 'dart:developer' as developer;
import 'dart:js_util';
import 'package:Vireg/src/_class/Connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:Vireg/src/_models/PersonalListModel.dart';
import 'package:Vireg/src/localization/app_localizations_context.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:localstore/localstore.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../_class/Loader.dart';
import '../_class/SnackBar.dart';
import '../_class/localstore.dart';
import '../_services/SharePersonalList.dart';
import '../_utils/front.dart';
import '../_widgets/boxCard.dart';
import '../_widgets/boxCardListPerso.dart';
import '../_widgets/dialogues.dart';
import '../_providers/localOnlineDevice.dart';

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
    print("init state home");
    ConectivityVireg(ref: ref,context: context).init();

    List listIdListShare = [];
    final LocalstorelocalObj = Localstorelocal(context: context,ref: ref);
    LocalstorelocalObj.getJsonAllPersonalistLocalStore().then((value)  async {
        value.forEach((element) {
          print(element['isListShare']);
          if(element['isListShare']){
            listIdListShare.add(element['id']);
          }
        });
        print(listIdListShare);
        if (ref.watch(localOnlineDeviceProvider) ) {
          print("LOAD");
        //  Loader(context: context, snackBar: false).showLoader();
          print('CONNECTION');

           SharePersonalList(context: context).UpdateOrDeleteLoadListeShare(listIdListShare: listIdListShare).then((value) async => {
             LocalstorelocalObj.getJsonAllPersonalistLocalStore().then((valueList) {
                    valueList.forEach((element)  {
                      PersonalListModel elementPersonalistModel = PersonalListModel.fromJson(element);
                      if (elementPersonalistModel.isListShare) {
                        bool existInBdd = value.toString().indexOf(elementPersonalistModel.id) > 0;
                        print("existe toujours en bdd: ${existInBdd.toString()}");
                        print(elementPersonalistModel);
                        if (!existInBdd) {
                          print("Delete: ${element['id']}");
                          Localstorelocal(context: context,ref: ref).deletePersonalList(personalList: elementPersonalistModel);
                        }
                      }
                    });
             }),
         /* await value["data"]?.forEach((element) async {
            dynamic elementObj = jsonDecode(element["data"]);
            print(elementObj['title']);
            dynamic newListVerb = [];
            print("************** ${elementObj['ListIdVerbs']}");
            for (var item in elementObj['ListIdVerbs']) {
              print(item);
              newListVerb.add(item);
            }
            //await _db.collection('personalLists').doc(element['uuid']).set(PersonalList(id: element['uuid'], title: elementObj['title'], color: int.parse(elementObj['color'].toString()), isListShare: true, ListIdVerbs: newListVerb).toMap());
          }),*/
          /*await _db.collection('personalLists').get().then((value) async {
            print(value);
            ListPerso = [];
            value?.entries.forEach((element) {
              print(element);
              bool isListShareCond=false;
              ListPerso.add(PersonalList(
                id: element.value['id'],
                title: element.value['title'],
                color: element.value['color'],
                ListIdVerbs: element.value['ListIdVerbs'],
                isListShare: nullToBool(valueNullToBool: element.value['isListShare']),
                ownListShare: nullToBool(valueNullToBool: element.value['ownListShare']),
              ));
            });

            loaderEnd=true;


            setState(() {});
          }),*/

        });



        }
      }
    );


    super.initState();

  }

  @override
  void dispose() {
    //_connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("build Home");
    dynamic ResponsiveContentObj=ResponsiveContent(context: context);
    dynamic DialoguesObj=Dialogues(context: context);
    if (!initConfig){
      Localstorelocal(ref: ref,context: context).initLang();
      initConfig=true;
    }
    Future<List<dynamic>> _futureOfListPerso() async => await Localstorelocal(ref: ref,context: context).getJsonAllPersonalistLocalStore();
    return Center(
      child: Column(
        children: [
          Visibility(visible: true,child: Text((ref.watch(localOnlineDeviceProvider) ? "online" : "offline"))),
          Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                    children:[
                      ElevatedButton(

                          onPressed: (){
                            context.go('/share/b96d2677-104b-4789-a030-fa8e249d7495');
                          },
                          child: Text('share test b96d2677-104b-4789-a030-fa8e249d7495')
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
              future: _futureOfListPerso(),
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
                                          alerOfflineBoxCard: () async => DialoguesObj.alertOffline()
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
                                        backgroundColor: (ref.watch(localOnlineDeviceProvider) ? Colors.blue : Colors.grey) ,
                                        onPressed: () {
                                          (ref.watch(localOnlineDeviceProvider)
                                              ?
                                              context.go("/")
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



/*
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('******************Couldn\'t check connectivity status: ', error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }
  bool isOnline=false;
  void _updateConnectionStatus(ConnectivityResult connectivityResult)  {
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.ethernet || connectivityResult == ConnectivityResult.vpn) {
      ref.read(localOnlineDeviceProvider.notifier).change(onlineDevice: true);
      print("OK connection: ${ref.watch(localOnlineDeviceProvider)}" );
      if(!isOnline) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        isOnline=true;
      }
    } else {
      ref.read(localOnlineDeviceProvider.notifier).change(onlineDevice: false);
      print("NO connection: ${ref.watch(localOnlineDeviceProvider)}" );
      if(isOnline) {
        SnakBar(context: context, messageSnackBar: "Vous êtes hors ligne",themeSnackBar: 'error',duration:3600).showSnakBar();
        isOnline=false;
      }
    }
   // setState(() {
   // });
  }
*/



}

