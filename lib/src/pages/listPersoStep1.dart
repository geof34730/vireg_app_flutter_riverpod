
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
import '../_models/PersonalListModel.dart';



import '../_class/Localstore.dart';

import '../_utils/front.dart';

var uuid = const Uuid();
class ListPersoStep1 extends ConsumerStatefulWidget {
  const ListPersoStep1({Key? key,this.idList }) : super(key: key);
  final String? idList;
  @override
  _ListPersoStep1State createState() => _ListPersoStep1State();
}

class _ListPersoStep1State extends ConsumerState<ListPersoStep1> {
  final titleList = TextEditingController();
  String? colorList = Colors.purple.value.toString();
  bool formValide = false;
  int etapeForm = 1;
  var localstoreLocalObj=null;
  String  UUIDList = uuid.v4();
  bool editMode=false;
  dynamic jsonEditPersonalList=null;
  bool loadDataEdit=false;
  late PersonalListModel PersonalListUpdate;

  @override
  void initState() {
    print("initState ListePersoStep1");
    if (!loadDataEdit){
      if (widget.idList != null) {
        editMode = true;
        UUIDList = widget.idList!;

        Localstorelocal(context: context,ref: ref).getJsonPersonalistLocalStore(idList: UUIDList).then((value){
          PersonalListUpdate=value;
          formValide = true;
          setState(() {});
        });


      }
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
            context.loc.listePersoCreateTitle,
            textAlign: TextAlign.left,
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: ResponsiveContent(context: context).choseSize(mobileSize: 20.00, otherSize: 25.00),
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
        Padding(
            padding: EdgeInsets.only(
              left: ResponsiveContent(context: context).choseSize(mobileSize: 20.00, otherSize: 35.00),
              right: ResponsiveContent(context: context).choseSize(mobileSize: 20.00, otherSize: 35.00),
              top: ResponsiveContent(context: context).choseSize(mobileSize: 10.00, otherSize: 10.00),
            ),
            child: TextFormField(
                controller: titleList,
                maxLength: 50,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: context.loc.listePersoLabelTitleField,
                  labelText:  context.loc.listePersoLabelTitleField,
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                ),
                onChanged: (value) {changeText(value:value);}
            )),
        Padding(
            padding: EdgeInsets.only(
              left: ResponsiveContent(context: context).choseSize(mobileSize: 20.00, otherSize: 35.00),
              right: ResponsiveContent(context: context).choseSize(mobileSize: 20.00, otherSize: 35.00),
              top: 10.00,
            ),
            child: Text(
              context.loc.listePersoChoiseColor,
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: ResponsiveContent(context: context).choseSize(mobileSize: 15.00, otherSize: 17.00),
                    fontWeight: FontWeight.bold,
                  )
              ),
            )),
        Padding(
            padding: EdgeInsets.only(
                left: ResponsiveContent(context: context).choseSize(mobileSize: 20.0, otherSize: 35.0),
                right: ResponsiveContent(context: context).choseSize(mobileSize: 20.0, otherSize: 35.0),
                top:10.00,
                bottom:10.0
            ),
            child: MaterialColorPicker(
              allowShades: true,
              onlyShadeSelection: false,
              onColorChange: (Color color) {
                colorList = color.value.toString();
                if(editMode) {
                  updatePersonalListStep1();
                }
                setState(() {});
              },
              selectedColor: Color(int.parse(colorList as String)),
            )),
        Center(
            child: ElevatedButton.icon(
              style: (formValide ? const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.green), foregroundColor: MaterialStatePropertyAll(Colors.white)) : const ButtonStyle()),
              onPressed: (formValide
                  ? () {
                       (editMode
                          ?
                          updatePersonalListStep1(next:true)
                          :
                           createList()
                        );


                      }
                  :
                  null
                  ),
              icon: const Icon(
                Icons.check,
                size: 19.0,
              ),
              label: Text(context.loc.listePersoButtonSuivant, style: TextStyle(fontSize: 19)),
            ))
      ],
    );
  }

  Future<void> createList() async {
    print("createLise");
    PersonalListUpdate =PersonalListModel(
        id: UUIDList.toString(),
        title: titleList.text,
        color: int.parse(colorList as String)
    );
    print(PersonalListUpdate);
    await Localstorelocal(ref: ref,context: context).createPersonalList(PersonalList:PersonalListUpdate);
    nextPersonalList();
    //setState(() {});
  }
  void changeText({required String value}){
    if(value != "") {
      formValide = true;
      if(editMode) {
        PersonalListUpdate=PersonalListUpdate.copyWith(title: value);
        print(PersonalListUpdate);
        updatePersonalListStep1();
      }
    }
    else{

      formValide = false;
    }
    setState(() {});
  }

  Future<void> updatePersonalListStep1({bool next =false}) async {
    print("update Personal List");
      await localstoreLocalObj.updatePersonalList(PersonalListUpdate);
      if(next){
        nextPersonalList();
      }

  }

  void nextPersonalList(){
    if(editMode){
      context.goNamed("editListPersoStep2",pathParameters: {'idList': UUIDList});
    }
    else{
      context.goNamed("addListPersoStep2",pathParameters: {'idList': UUIDList.toString()});
    }
  }
}





