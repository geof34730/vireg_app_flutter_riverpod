import 'dart:math';

import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../_class/PlaySoond.dart';
import '../_providers/localLang.dart';
import 'package:Vireg/src/localization/app_localizations_context.dart';
import '../_Utils/string.dart';
import '../_class/GetDataVerbs.dart';
import 'package:flip_card/flip_card.dart';

import '../_widgets/textFormVireg.dart';

class TestVerb extends ConsumerStatefulWidget {
  const TestVerb({Key? key,required this.idList, required this.personalList, required this.idVerb }) : super(key: key);
  final String? idList;
  final String? idVerb;
  final String? personalList;

  @override
  _TestVerbState createState() => _TestVerbState();
}



class _TestVerbState extends ConsumerState<TestVerb> {
  String locallang="";
  late String StockFrancais="";
  final  TextEditingController controllerFrancais=TextEditingController();

  late String StockInfinitif="";
  late TextEditingController controllerInfinitif=TextEditingController();

  late String StockPastSimple="";
  late TextEditingController controllerPastSimple=TextEditingController();

  late String StockPastParticipe="";
  late TextEditingController controllerPastParticipe=TextEditingController();


  late  bool viewButtonNextTest=false;
  late bool personalList;
  late bool readJsonOk=false;

  @override
  void initState() {
    personalList = (widget.personalList=='true' ? true : false);
    readJson(idList: widget.idList.toString(),idVerb: widget.idVerb, personalList: personalList);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    locallang=ref.watch(localLangProvider);
    if(readJsonOk) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextFormViregClass(context: context,
            ControlerField: controllerFrancais,
            StockField: StockFrancais,
            labelField: context.loc.listVersItemLang,
            firstField: true,
            updateStateParent: () =>
            {
              if (mounted) {
                setState(() {})
              }
            },
          ),
          TextFormViregClass(context: context,
            ControlerField: controllerInfinitif,
            StockField: StockInfinitif,
            labelField: "Infinitive",
            firstField: false,
            updateStateParent: () =>
            {
              if (mounted) {
                setState(() {})
              }
            },
          ),
          TextFormViregClass(context: context,
            ControlerField: controllerPastSimple,
            StockField: StockPastSimple,
            labelField: "Past Simple",
            firstField: false,
            updateStateParent: () =>
            {
              if (mounted) {
                setState(() {})
              }
            },
          ),
          TextFormViregClass(context: context,
            ControlerField: controllerPastParticipe,
            StockField: StockPastParticipe,
            labelField: "Past Participle",
            firstField: false,
            updateStateParent: () =>
            {
              if (mounted) {
                setState(() {})
              }
            },
          ),
          Padding(
              padding: const EdgeInsets.only(
                  left: 10.0, right: 10.0, top: 10.00),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                ElevatedButton.icon(
                  key:UniqueKey(),
                  onPressed: () {
                    controllerFrancais.text = StockFrancais;
                    controllerInfinitif.text = StockInfinitif;
                    controllerPastSimple.text = StockPastSimple;
                    controllerPastParticipe.text = StockPastParticipe;
                    if (mounted) {
                      setState(() {});
                    }
                  },
                  icon: const Icon(
                    Icons.visibility,
                    size: 19.0,
                  ),
                  label: Text(context.loc.testVerbsButtonSolutions,
                      style: TextStyle(fontSize: 19)),
                ),
                  Visibility(
                    visible:  widget.idVerb==null,
                    child: Visibility(
                          visible: viewButtonNextTest,
                          child: Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: ElevatedButton.icon(
                                key:UniqueKey(),
                                style: (goNextVerb() ? ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Colors.green
                                    ),
                                    foregroundColor: MaterialStatePropertyAll(
                                        Colors.white
                                    )
                                )
                                : null),
                                onPressed: (goNextVerb() ? () {
                                  readJson(idList: widget.idList.toString(),idVerb: widget.idVerb,personalList: personalList);
                                } : null),
                                icon: const Icon(
                                  Icons.check,
                                  size: 19.0,
                                ),
                                label: Text(context.loc.testVerbsButtonSuivant,
                                    style: TextStyle(fontSize: 19)),
                              ))
                      )
                  )
              ]))
        ],
      );
    }
    else{
      return Text("");
    }
  }

  bool goNextVerb() {
    if (removeDiacritics(controllerFrancais.text.toUpperCase()) == removeDiacritics(StockFrancais.toUpperCase()) &&
        removeDiacritics(controllerInfinitif.text.toUpperCase()) == removeDiacritics(StockInfinitif.toUpperCase()) &&
        removeDiacritics(controllerPastSimple.text.toUpperCase()) == removeDiacritics(StockPastSimple.toUpperCase()) &&
        removeDiacritics(controllerPastParticipe.text.toUpperCase()) == removeDiacritics(StockPastParticipe.toUpperCase())) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> readJson({required String idList,required String? idVerb, String? valueSearch,required bool personalList}) async {
    //print("************************ $data");
    bool resultSearch=false;
    int numberVerbData = 0;
    if (idVerb!=null) {
      List<dynamic> data = await GetDataVerbs().getDataJson(idList: "top200", idVerb: idVerb, personalList: personalList);
      //FirebaseAnalytics.instance.setCurrentScreen(screenName: "search");
      //manageInsterstitial();
      StockFrancais = toTitleCase(data[0][ref.watch(localLangProvider)]);
      StockInfinitif = toTitleCase(data[0]['infinitif']);
      StockPastSimple = toTitleCase(data[0]['pastSimple']);
      StockPastParticipe = toTitleCase(data[0]['pastParticipe']);

    } else {
      //FirebaseAnalytics.instance.setCurrentScreen(screenName: "verb_$typeListe");
      //manageInsterstitial();
      List<dynamic> data = await GetDataVerbs().getDataJson(idList: idList, idVerb: null, personalList: personalList);
      int randomNumberCarbData = Random().nextInt(data.length);
      StockFrancais = data[randomNumberCarbData][ref.watch(localLangProvider)];
      StockInfinitif = data[randomNumberCarbData]['infinitif'];
      StockPastSimple = data[randomNumberCarbData]['pastSimple'];
      StockPastParticipe = data[randomNumberCarbData]['pastParticipe'];
    }

    controllerFrancais.text = "";
    controllerInfinitif.text = "";
    controllerPastSimple.text = "";
    controllerPastParticipe.text = "";
      switch (Random().nextInt(4)) {
        case 0:
          {
            controllerFrancais.text = StockFrancais;
          }
          break;
        case 1:
          {
            controllerInfinitif.text = StockInfinitif;
          }
          break;
        case 2:
          {
            controllerPastSimple.text = StockPastSimple;
          }
          break;
        case 3:
          {
            controllerPastParticipe.text = StockPastParticipe;
          }
          break;
      }

      setState(() {
        viewButtonNextTest = true;
        readJsonOk=true;
      });
  }
}
