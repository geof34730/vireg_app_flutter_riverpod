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
  const TestVerb({Key? key,required this.idList, required this.personalList }) : super(key: key);
  final String? idList;
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

  @override
  void initState() {
    personalList = (widget.personalList=='true' ? true : false);
    readJson(idList: widget.idList.toString(),personalList:personalList);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    locallang=ref.watch(localLangProvider);


    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormViregClass(context:context,ControlerField: controllerFrancais, StockField: StockFrancais, labelField: context.loc.listVersItemLang, firstField: true,
          updateStateParent:  () => {
            setState(() {
            })
          },
        ),
        TextFormViregClass(context:context,ControlerField: controllerInfinitif, StockField: StockInfinitif, labelField: "Infinitive", firstField: false,
          updateStateParent:  () => {
            setState(() {
            })
          },
        ),
        TextFormViregClass(context:context,ControlerField: controllerPastSimple, StockField: StockPastSimple, labelField: "Past Simple", firstField: false,
          updateStateParent:  () => {
            setState(() {
            })
          },
        ),
        TextFormViregClass(context:context,ControlerField: controllerPastParticipe, StockField: StockPastParticipe, labelField: "Past Participle", firstField: false,
          updateStateParent:  () => {
            setState(() {
            })
          },
        ),
        Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.00),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              ElevatedButton.icon(
                onPressed: () {
                  controllerFrancais.text = StockFrancais;
                  controllerInfinitif.text = StockInfinitif;
                  controllerPastSimple.text = StockPastSimple;
                  controllerPastParticipe.text = StockPastParticipe;
                  setState(() {});
                },
                icon: const Icon(
                  Icons.visibility,
                  size: 19.0,
                ),
                label:  Text(context.loc.testVerbsButtonSolutions, style: TextStyle(fontSize: 19)),
              ),
              Visibility(
                  visible: viewButtonNextTest,
                  child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: ElevatedButton.icon(
                        style:(goNextVerb() ? ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green), foregroundColor: MaterialStatePropertyAll(Colors.white)) : null),
                        onPressed:(goNextVerb() ? (){readJson(idList: widget.idList.toString(),personalList: personalList);} : null),
                        icon: const Icon(
                          Icons.check,
                          size: 19.0,
                        ),
                        label: Text(context.loc.testVerbsButtonSuivant, style: TextStyle(fontSize: 19)),
                      ))
                  )
            ]))
      ],
    );
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

  Future<void> readJson({required String idList, String? valueSearch,required bool personalList}) async {
    List<dynamic> data = await GetDataVerbs().getDataJson(idList: idList,personalList:personalList);
    print("************************ $data");
    bool resultSearch=false;
    int numberVerbData = 0;
    if (resultSearch) {
      //FirebaseAnalytics.instance.setCurrentScreen(screenName: "search");
      //manageInsterstitial();
      /*
      int numericItem = int.parse(numItem);
      StockFrancais = toTitleCase(data[numericItem][ref.watch(localLangProvider)]);
      StockInfinitif = toTitleCase(data[numericItem]['infinitif']);
      StockPastSimple = toTitleCase(data[numericItem]['pastSimple']);
      StockPastParticipe = toTitleCase(data[numericItem]['pastParticipe']);
       */
    } else {
      //FirebaseAnalytics.instance.setCurrentScreen(screenName: "verb_$typeListe");
      //manageInsterstitial();
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


    if (resultSearch) {
      if (StockFrancais == valueSearch) {
        controllerFrancais.text = StockFrancais;
      }
      if (StockInfinitif == valueSearch) {
        controllerInfinitif.text = StockInfinitif;
      }
      if (StockPastSimple == valueSearch) {
        controllerPastSimple.text = StockPastSimple;
      }
      if (StockPastParticipe == valueSearch) {
        controllerPastParticipe.text = StockPastParticipe;
      }
      setState(() {
        viewButtonNextTest = false;
      });
    } else {
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
      });
    }
  }


}
