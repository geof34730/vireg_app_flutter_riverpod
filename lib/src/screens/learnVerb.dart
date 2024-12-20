import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../_class/PlaySoond.dart';
import '../_providers/localLang.dart';
import 'package:Vireg/src/localization/app_localizations_context.dart';
import '../_Utils/string.dart';
import '../_class/GetDataVerbs.dart';
import 'package:flip_card/flip_card.dart';
import 'package:Vireg/src/router.dart';


import '../_utils/logger.dart';

class LearnVerb extends ConsumerStatefulWidget {
  const LearnVerb({Key? key,required this.idList, required this.personalList }) : super(key: key);
  final String? idList;
  final String? personalList;

  @override
  _LearnVerbState createState() => _LearnVerbState();
}

class _LearnVerbState extends ConsumerState<LearnVerb> {
  List<GlobalKey<FlipCardState>> cardKeys = [];
  late List<dynamic> dataList = [];
  int learnNumCard = 1;
  String positionCard="front";
  bool visibleButtonPlay=false;
  String locallang="";
  late bool personalList;
  late bool getdataListOK=false;
  @override
  void initState() {
    personalList = (widget.personalList=='true' ? true : false);
    getListVerbsJson(idList: widget.idList.toString()).then((value) => getdataList(idList: widget.idList.toString(), personalList: personalList));
    learnNumCard = 1;
    visibleButtonPlay=false;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    locallang=ref.watch(localLangProvider);
    //print("dataList.isEmpty: ${dataList.isEmpty}");




    if(getdataListOK) {
      if (dataList.isEmpty) {
        return FutureBuilder<List<dynamic>>(
            future: getdataList(idList: widget.idList.toString(), personalList: personalList),
            initialData: dataList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {
                  return SizedBox();
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
            });
      }
      if (cardKeys.length != dataList.length + 1) {
        cardKeys = [];
        for (int i = 0; i < dataList.length + 1; i++) {
          cardKeys.add(GlobalKey<FlipCardState>());
        }

        if (this.mounted) { // check whether the state object is in tree
          setState(() {
            // make changes here
          });
        }
      }
      double sizeCard = getWidthAndHeightCard();
      return Column(mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Column(mainAxisSize: MainAxisSize.max, children: [
              Padding(
                padding: EdgeInsets.only(top: 15.0, bottom: 10.0),
                child: Text("${context.loc.learnClickCarte}"),
              )
            ]),
            GestureDetector(
              onHorizontalDragEnd: (DragEndDetails details) {
                if (details.primaryVelocity! > 0) {
                  learnBack();
                } else if (details.primaryVelocity! < 0) {
                  learnNext();
                }
              },
              child: SizedBox(
                width: sizeCard,
                height: sizeCard,
                child: InkWell(
                    key:UniqueKey(),
                    onTap: () {
                      cardKeys[learnNumCard].currentState?.toggleCard();
                      setState(() {
                        if (positionCard == 'back') {
                          positionCard = 'front';
                        }
                        else {
                          positionCard = 'back';
                        }
                      });
                    },
                    child: Stack(
                        children: [
                          AnimatedPositioned(
                              width: sizeCard,
                              height: sizeCard,
                              curve: Curves.easeInOut,
                              left: getPositionCardWraperCard(
                                  learnNumCard: learnNumCard),
                              duration: const Duration(milliseconds: 500),
                              child: Wrap(
                                  direction: Axis.vertical,
                                  spacing: 30.0,
                                  // gap between adjacent chips
                                  runSpacing: getWidthAndHeightCard() / 15,
                                  // gap between lines
                                  children: [
                                    SizedBox(
                                      key: cardKeys[0],
                                      width: sizeCard,
                                      height: sizeCard,
                                    ),
                                    for (int i = 0; i <
                                        dataList.length; i++) ...[
                                      FlipCard(
                                        onFlip: () {
                                          visibleButtonPlay = false;
                                          setState(() {});
                                        },
                                        onFlipDone: (isFront) {
                                          if (isFront) {
                                            //widget.returnManageInsterstitial.call();
                                          }
                                          visibleButtonPlay = isFront;
                                          setState(() {});
                                        },
                                        key: cardKeys[i + 1],
                                        fill: Fill.fillBack,
                                        flipOnTouch: true,
                                        direction: FlipDirection.HORIZONTAL,
                                        front: Container(
                                            padding: const EdgeInsets.only(
                                                left: 5.0, right: 5.0),
                                            width: sizeCard,
                                            height: sizeCard,
                                            color: Colors.blue,
                                            child: Center(
                                                child: Text(
                                                  toTitleCase(
                                                      dataList[i][locallang]),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      fontSize: 30.00),
                                                  textAlign: TextAlign.center,
                                                ))),
                                        back: Container(
                                            padding: const EdgeInsets.only(
                                                left: 5.0, right: 5.0),
                                            width: sizeCard,
                                            height: sizeCard,
                                            color: Colors.blue,
                                            child: Center(
                                                child: Text(
                                                  "(inf) ${toTitleCase(
                                                      dataList[i]['infinitif']
                                                          .toString())}\n(ps) ${toTitleCase(
                                                      dataList[i]['pastSimple']
                                                          .toString())}\n(pp) ${toTitleCase(
                                                      dataList[i]["pastParticipe"]
                                                          .toString())}",
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      fontSize: 30.00),
                                                  textAlign: TextAlign.center,
                                                ))),
                                      ),
                                    ],
                                  ])

                          ),
                          Visibility(
                              visible: visibleButtonPlay,
                              child: Positioned(
                                top: 20,
                                right: 20,
                                child: SizedBox(
                                    height: 54,
                                    width: 54,
                                    child: PlaySoond(
                                        dataVerbe: dataList[learnNumCard - 1],
                                        typeAudio: "all",
                                        iconColor: Colors.black,
                                        buttonColor: Colors.white,
                                        sizeIcon: 30).buttonPlay()
                                ),
                              )
                          )
                        ])
                ),
              ),
            ),


            Column(
                mainAxisSize: MainAxisSize.max, children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Visibility(
                        visible: learnNumCard != 1 && learnNumCard != 0,
                        child: FloatingActionButton(
                          heroTag: UniqueKey(),
                          onPressed: () async {
                            learnBack();
                          },
                          backgroundColor: Colors.blue,
                          child: const Icon(
                            Icons.navigate_before,
                            color: Colors.white,
                          ),
                        ),
                      )
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: 25.0,
                          left: (learnNumCard == 1 ? 55 : 0),
                          right: (learnNumCard == dataList.length ? 55 : 0)),
                      child: Text('$learnNumCard/${dataList.length}')
                  ),


                  Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Visibility(
                        visible: learnNumCard <= dataList.length - 1,
                        child: FloatingActionButton(
                          heroTag: UniqueKey(),
                          onPressed: () {
                            learnNext();
                          },
                          backgroundColor: Colors.blue,
                          child: const Icon(
                            Icons.navigate_next,
                            color: Colors.white,
                          ),
                        ),
                      )
                  )
                ],
              ),
            ])
          ]);
    }
    else{
      return Text('Loading Data');
    }




  }


  Future<List<dynamic>> getdataList({required String idList, required bool personalList}) async {
    Logger.Green.log("personalList $personalList");
    Logger.Green.log('getdataList : $idList');
    List<dynamic> dataListResp=await GetDataVerbs().getDataJson(idList: idList,personalList: personalList);
    dataList=dataListResp.toList();
    if(!getdataListOK) {
      setState(() {
        getdataListOK = true;
      });
    }

    return dataList;
  }

  Future<void> getListVerbsJson({required String idList}) async {
    List<dynamic> dataListResp=await GetDataVerbs().getDataJson(idList: idList,personalList: personalList);
    dataList=dataListResp.toList();

    if (this.mounted) { // check whether the state object is in tree
      setState(() {
        dataList=dataListResp.toList();
      });
    }



  }

  double getWidthAndHeightCard() {
    if(MediaQuery.of(context).size.width / 1.1<MediaQuery.of(context).size.height/ 1.7) {
      return MediaQuery
          .of(context)
          .size
          .width / 1.1;
    }
    else{
      return MediaQuery
          .of(context)
          .size
          .height / 1.7;
    }
  }

  double getPositionCardWraperCard({required int learnNumCard}) {
    if (learnNumCard == 0) {
      return 0;
    } else {
      return -((getWidthAndHeightCard() + (getWidthAndHeightCard() / 15)) * learnNumCard);
    }
  }

  Future<void> learnNext() async {
    if(learnNumCard <= dataList.length - 1) {
      if (positionCard == 'back') {
        cardKeys[learnNumCard].currentState?.toggleCard();
      }
      positionCard = "front";
      learnNumCard = learnNumCard + 1;
      //widget.returnManageInsterstitial.call();
      await FirebaseAnalytics.instance.setCurrentScreen(
          screenName:"Learn next"
      );
      setState(() {});

     // _adManager.showInterstitialAd();

    }
  }

  void learnBack(){

    if(learnNumCard != 1 && learnNumCard != 0) {
      if (positionCard == 'back') {
        cardKeys[learnNumCard].currentState?.toggleCard();
      }
      positionCard = "front";
      learnNumCard = learnNumCard - 1;
      //widget.returnManageInsterstitial.call();
      setState(() {});
    }
  }

}
