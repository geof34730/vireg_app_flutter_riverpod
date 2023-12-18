
import 'dart:convert';

import 'package:Vireg/src/_models/PersonalListModel.dart';
import 'package:Vireg/src/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Vireg/src/localization/app_localizations_context.dart';
import 'package:uuid/uuid.dart';


import '../_class/FormatData.dart';
import '../_class/Localstore.dart';
import '../_utils/front.dart';

var uuid = const Uuid();
class ListPersoStep2 extends ConsumerStatefulWidget {
  const ListPersoStep2({Key? key,this.idList }) : super(key: key);
  final String? idList;
  @override
  _ListPersoStep2State createState() => _ListPersoStep2State();
}

class _ListPersoStep2State extends ConsumerState<ListPersoStep2> {
  late String titleList = "";
  String? colorList = "";
  bool formValide = false;
  int etapeForm = 2;
  var localstoreLocalObj=null;
  var UUIDList = "";
  dynamic jsonEditPersonalList=null;
  bool loadDataEdit=false;
  dynamic listIdVerbs=[];
  bool isListShare = false;
  bool ownListShare = false;


  @override
  void initState() {
    print("initState ListePersoStep2");
    if (!loadDataEdit){
        UUIDList = widget.idList!;
        Localstorelocal(ref: ref, context: context).getJsonPersonalistLocalStore(idList: UUIDList).then((value) {
          titleList = value["title"];
          colorList = value["color"].toString();
          listIdVerbs = value["listIdVerbs"];
          isListShare = value["isListShare"];
          ownListShare = value["ownListShare"];
          loadDataEdit=true;
          setState(() {

          });
        });
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    localstoreLocalObj=Localstorelocal(ref: ref,context: context);

    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: ResponsiveContent(context: context).choseSize(mobileSize: 20.00, otherSize: 35.00),
            top: ResponsiveContent(context: context).choseSize(mobileSize: 20.00, otherSize: 35.00) + 10.00,
          ),
          child: Text(
            "${widget.idList}  -  ${context.loc.listePersoCreateTitle}",
            textAlign: TextAlign.left,
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: ResponsiveContent(context: context).choseSize(mobileSize: 20.00, otherSize: 25.00),
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),

      ],
    );
  }












  Future<void> updatePersonalListStep() async {
    print("update Personal List");
    await localstoreLocalObj.updatePersonalList(
      UUIDList:UUIDList,
      titleList:titleList,
      colorList:int.parse(colorList  as String),
      listIdVerbs:listIdVerbs,
      isListShare : isListShare,
      ownListShare : ownListShare,
    );
  }




}





