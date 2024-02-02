import 'dart:convert';
import 'dart:core';
import 'dart:async';
import 'dart:developer' as developer;
import 'package:flutter/services.dart';
import 'package:Vireg/src/_models/PersonalListModel.dart';
import 'package:Vireg/src/localization/app_localizations_context.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../_class/Loader.dart';
import '../_class/localLang.dart';
import '../_class/localstore.dart';
import '../_services/SharePersonalList.dart';
import '../_utils/front.dart';
import '../_widgets/boxCard.dart';
import '../_widgets/boxCardListPerso.dart';
import '../router.dart';
import '../_class/localOnlineDevice.dart';


bool initConfig=false;

class Home extends ConsumerStatefulWidget {
  const Home({Key? key }) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  final FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  bool isoffline=true;
  //ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    print("init state home");
    super.initState();
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    late Localstorelocal localstoreLocalObj=Localstorelocal(ref: ref,context: context);
    print("build Home");
    if (!initConfig){
      localstoreLocalObj.initLang();
      initConfig=true;
    }
    Future<List<dynamic>> _futureOfListPerso() async => await Localstorelocal(ref: ref,context: context).getJsonAllPersonalistLocalStore();
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
                          child: Text(ref.watch(localOnlineDeviceProvider).toString())
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
                                for (int i = 0; i < snapshot.data!.length; i++)
                                  ...[
                                  ResponsiveGridCol(
                                      xs: 12,
                                      sm:getFlexListePerso(lenghtVerbs:snapshot.data!.length,numVerb:i),
                                      md: getFlexListePerso(lenghtVerbs:snapshot.data!.length,numVerb:i),
                                      child: BoxCardListPerso(
                                          context:context,
                                          personalList:personalListModelFromJson(jsonEncode(snapshot.data![i]).toString()),
                                          onClickShare: ({required String idList}) async =>(ref.watch(localOnlineDeviceProvider) ? shareListPerso(personalList: personalListModelFromJson(jsonEncode(snapshot.data![i]).toString())) : alertOffline())
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
                                      padding: EdgeInsets.only(bottom: 10.00,right: 5.0, top: ResponsiveContent(context: context).choseSize(mobileSize: 5.00, otherSize: 10.00)),
                                      child: FloatingActionButton(
                                        elevation: 10,
                                        backgroundColor: (ref.watch(localOnlineDeviceProvider) ? Colors.blue : Colors.grey) ,
                                        onPressed: () {
                                          (ref.watch(localOnlineDeviceProvider)
                                              ?
                                              context.go("/")
                                              :
                                              alertOffline()
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

  Future<void> shareListPerso({required PersonalListModel personalList}) async {
    Loader(context: context, snackBar: false).showLoader();
    if(personalList.urlShare=="") {
      SharePersonalList(context: context).Share(personalList: personalList).then((value) async {
        value = await value.copyWith(isListShare: true,ownListShare: true);
        await Localstorelocal(context: context, ref: ref).updatePersonalList(PersonalList: value);
        _dialogBuilderShare(context: context, personalList: value);
        setState(() {

        });
        Loader(context: context, snackBar: false).hideLoader();
      });
    }
    else{
      _dialogBuilderShare(context: context, personalList: personalList);
      Loader(context: context, snackBar: false).hideLoader();
    }
  }
  void sendQrCode({required BuildContext context,required PersonalListModel personalList }) {
    Navigator.of(context).pop();
    _dialogBuilderShare(context: context,personalList: personalList);
  }

  Future<void> _dialogBuilderShare({required BuildContext context,required PersonalListModel personalList }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          //  scrollDirection: Axis.vertical,
            child: AlertDialog(
              insetPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              icon: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.end, children: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.close,
                    ))
              ]),
              title: const Text(
                'Partager votre liste personnalisée',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.00),
              ),
              content: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                const SizedBox(
                    width: 360,
                    height: 40,
                    child: Text(
                      'En faisant scanner le QR code ci-dessous à la personne avec qui vous souhaitez partager cette liste',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.00),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 10.00, bottom: 10.0),
                  child: Container(
                      width: 280,
                      height: 280,
                      color: Colors.blue,
                      child: QrImageView(
                        data: personalList.urlShare,
                        version: 10,
                        size: 280,
                        gapless: true,
                        backgroundColor: Colors.white,
                      )),
                ),
                const Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'OU',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18.00, fontWeight: FontWeight.bold),
                    )),
                const Text(
                  'En envoyant le QR code de votre liste par email',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.00),
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ElevatedButton.icon(
                          onPressed: () async {
                            sendQrCode(context: context,personalList: personalList);
                          },
                          icon: const Icon(
                            Icons.email,
                          ),
                          label: const Text(
                            "Partager par email",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )))
                ])
              ]),
            ));
      },
    );
  }

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

  Future<void> _updateConnectionStatus(ConnectivityResult connectivityResult) async {
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.ethernet || connectivityResult == ConnectivityResult.vpn) {
      ref.read(localOnlineDeviceProvider.notifier).change(onlineDevice: true);
    } else {
      ref.read(localOnlineDeviceProvider.notifier).change(onlineDevice: false);
      print("plus de connection");
    }
    //setState(() {
    //_connectionStatus = result;
    // });
  }

  Future<String?> alertOffline() {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                 SizedBox(
                    width:280.0,
                    child:Text(
                      context.loc.alertOffLine,
                      style: TextStyle(color: Colors.red, fontSize: 16.0),
                      textAlign: TextAlign.center,
                    )
                ),
                const SizedBox(height: 15, width: 150),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(context.loc.fermer),
                ),
              ],
            ),
          ),
        ));
  }


}