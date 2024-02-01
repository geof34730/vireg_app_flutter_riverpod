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
import 'package:Vireg/src/_class/Localstore.dart';
import 'package:Vireg/src//_utils/front.dart';

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
  var localstoreLocalObj=null;
  String  UUIDList = uuid.v4();
  bool editMode=false;
  bool loadDataEdit=false;
  late PersonalListModel  PersonalListUpdate= new PersonalListModel(id: UUIDList.toString(), title: "",ListIdVerbs: [], color: int.parse(colorList as String));

  @override
  void initState() {
    if (!loadDataEdit){
      if (widget.idList != null) {
        editMode = true;
        UUIDList = widget.idList.toString();
        Localstorelocal(context: context,ref: ref).getJsonPersonalistLocalStore(idList: UUIDList.toString()).then((value){
          PersonalListUpdate=value;
          formValide = true;
          loadDataEdit=true;
          setState(() {
            titleList.text=PersonalListUpdate.title;
          });
        });
      }
      else{
        setState(() {
          titleList.text=PersonalListUpdate.title;
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
            child:MaterialColorPicker(
              allowShades: true,
              onlyShadeSelection: false,
              onColorChange: (Color color) {
                colorList = color.value.toString();
                PersonalListUpdate=PersonalListUpdate.copyWith(color: int.parse(color.value.toString()));
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
    PersonalListUpdate =PersonalListModel(
        id: UUIDList.toString(),
        title: titleList.text,
        color: int.parse(colorList as String)
    );
   await Localstorelocal(ref: ref,context: context).createPersonalList(PersonalList:PersonalListUpdate);
    nextPersonalList();
  }

  void changeText({required String value}){
    if(value != "") {
      formValide = true;
      PersonalListUpdate=PersonalListUpdate.copyWith(title: value.toString());
      if(editMode) {
        updatePersonalListStep1();
      }
      formValide = true;
    }
    else{
      formValide = false;
    }
    setState(() {});
  }

  Future<void> updatePersonalListStep1({bool next =false}) async {
      localstoreLocalObj.updatePersonalList(PersonalList:PersonalListUpdate);
      if(next){
        nextPersonalList();
      }
  }

  void nextPersonalList(){
    context.goNamed((editMode ? "editListPersoStep2": "addListPersoStep2"),pathParameters: {'idList': PersonalListUpdate.id.toString()});
  }

}





