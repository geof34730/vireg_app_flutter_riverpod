import 'package:Vireg/src/_models/PersonalListModel.dart';
import 'package:Vireg/src/localization/app_localizations_context.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../_Utils/string.dart';
import '../_class/DataTableListeVerbes.dart';
import '../_class/DataTableListeVerbesPersoAction.dart';
import '../_class/GetDataVerbs.dart';
import '../_class/Localstore.dart';
import '../_class/localLang.dart';
import '../_models/ListVerbsModel.dart';
import '../_services/SharePersonalList.dart';
import '../_utils/front.dart';
import '../router.dart';


class ListPersoStep2 extends ConsumerStatefulWidget {
  const ListPersoStep2({Key? key, required this.idList}) : super(key: key);
  final String? idList;
  @override
  _ListPersoStep2State createState() => _ListPersoStep2State();
}

class _ListPersoStep2State extends ConsumerState<ListPersoStep2> {
  final searchController = TextEditingController();
  List<dynamic> filteredData = [];
  List<dynamic> dataList=[];
  final keydataTable = GlobalKey<PaginatedDataTableState>();
  String locallang="";
  bool form2Valide=false;
  String UUIDList="";
  String titleList="";
  int colorList=0;
  bool isListShare=false;
  bool ownListShare=false;


  @override
  void initState() {
    UUIDList=widget.idList.toString();
    print('initstat ListVerb');
    Localstorelocal(context: context,ref: ref).getJsonPersonalistLocalStore(idList: widget.idList.toString()).then((value){
      UUIDList= widget.idList.toString();
      titleList=value["title"];
      colorList= value["color"];
      isListShare= value["isListShare"];;
      ownListShare= value["ownListShare"];;
    });
    getListVerbsJson(idList: widget.idList.toString());
    super.initState();
  }

  @override
  void dispose() {
    searchController.text = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UUIDList=widget.idList.toString();
    locallang=ref.watch(localLangProvider);
    return Column(mainAxisAlignment: MainAxisAlignment.start, mainAxisSize: MainAxisSize.max, children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
              hintText: 'Filtrer...',
              border: const OutlineInputBorder(),
              suffixIcon: searchController.text.isNotEmpty
                  ? Padding(
                padding: const EdgeInsetsDirectional.only(start: 12.0),
                child: IconButton(
                  iconSize: 30.0,
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    setState(() {
                      searchController.clear();
                      _onSearchTextChanged(text: "",LocalLangParam: locallang);
                      keydataTable.currentState?.pageTo(0);
                    });
                  },
                ),
              )
                  : null),
          onChanged: (text)=>{_onSearchTextChanged(text: text,LocalLangParam: locallang)},
        ),
      ),
      SizedBox(
        width: ResponsiveContent(context: context).sizeFlex(flexNumber: 12),
        child: PaginatedDataTable(
                  key: keydataTable,
                  columnSpacing: 5.0,
                  dataRowMinHeight: 70.00,
                  dataRowMaxHeight: 70.00,
                  headingRowHeight: 90.0,
                  rowsPerPage: 10,
                  showFirstLastButtons: true,
                  columns: <DataColumn>[
                    DataColumn(
                      label: ConstrainedBox(
                        constraints: constraintsDataColumn(flexNumber: 4),
                        child:  Text(capitalize(context.loc.listVersItemLang), overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    DataColumn(
                        label: ConstrainedBox(
                          constraints: constraintsDataColumn(flexNumber: 4), //SET max width
                          child: const Text('(inf) Infinitive\n(ps)Past Simple\n(pp)Past Participle',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                height: 1.5,
                              )),
                        )),
                    DataColumn(
                        label: ConstrainedBox(
                            constraints: constraintsDataColumn(flexNumber: 2), //SET max width
                            child:  Center(child:Text(context.loc.listVersAudios,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  height: 1.5,
                                )),
                            )
                        )),
                  ],
                  source: DataTableListeVerbesPersoAction(
                      localLang: locallang,
                      filteredData: filteredData,
                      context: context,
                      addOrDeleteInList: ({required idVerbs}) =>
                      {
                        addOrDeleteInList(idVerbs: idVerbs)
                      }),
                )

      ),
    ]);
  }






  dynamic constraintsDataColumn({required int flexNumber}){
    return BoxConstraints(
        minWidth: ResponsiveContent(context: context).choseSize(
          mobileSize: ResponsiveContent(context: context).sizeFlex(flexNumber: flexNumber),
          otherSize:  ResponsiveContent(context: context).sizeFlex(flexNumber: flexNumber),
        ),
        maxWidth: ResponsiveContent(context: context).choseSize(
          mobileSize: ResponsiveContent(context: context).sizeFlex(flexNumber: flexNumber),
          otherSize:  ResponsiveContent(context: context).sizeFlex(flexNumber: flexNumber),
        )
    );
  }

  void _onSearchTextChanged({required String text,required String LocalLangParam}) {
    setState(() {
      filteredData = text.isEmpty
          ? dataList
          : dataList
          .where((item) =>
          removeDiacritics(item['infinitif']).toLowerCase().contains(removeDiacritics(text).toLowerCase()) ||
          removeDiacritics(item['pastSimple']).toLowerCase().contains(removeDiacritics(text).toLowerCase()) ||
          removeDiacritics(item['pastParticipe']).toLowerCase().contains(removeDiacritics(text).toLowerCase()) ||
          removeDiacritics(item[LocalLangParam]).toLowerCase().contains(removeDiacritics(text).toLowerCase()))
          .toList();
      keydataTable.currentState?.pageTo(0);
    });
  }

  List sortVerbsByFrancais(datas) {
    datas.sort((a, b) {
      return removeDiacritics(a[ref.watch(localLangProvider)])
          .toString()
          .toLowerCase()
          .compareTo(removeDiacritics(b[ref.watch(localLangProvider)]).toString().toLowerCase());
    });
    return datas;
  }


  Future<List<dynamic>> getListVerbsJson({required String idList}) async {
    List<dynamic> dataListAll=await GetDataVerbs().getDataJson(idList: "top200");
    dataList=dataListAll.toList();
    List<dynamic> dataListPerso=await GetDataVerbs().getDataJson(idList: idList,personalList: true);
    for (var iTemsdataLists in dataList){
      iTemsdataLists["isInListPerso"]=false;
      for (var iTemsdataListPerso in dataListPerso){
          if(iTemsdataLists["id"].toString()==iTemsdataListPerso["id"].toString()){
            iTemsdataLists["isInListPerso"]=true;
            break;
          }
      }
    }
    filteredData = sortVerbsByFrancais(dataList);
    setState(() {

    });
    return filteredData;
  }

  Future<void> updataDataShare() async {
    print("update data share Function $UUIDList");
    dynamic newListVerb = [];
    await db.collection('personalList').doc(UUIDList).get().then((value) async {

      print(value?['ownListShare']);

      if(value?['ownListShare']) {
        print("go update server");
        late List<ListVerbsModel> ListVerb = value?['listIdVerbs'];
        for (var item in ListVerb) {
          newListVerb.add(item);
        }
        SharePersonalList(context:context).Share(
            idListPerso: UUIDList,
            ListePerso:PersonalListModel(
                isListShare: value?['isListShare'],
                ownListShare: value?['ownListShare'],
                id: UUIDList,
                title: titleList,
                color: int.parse(colorList as String),
                listIdVerbs: newListVerb
            )
        );
      }
      else{
        print("NO go update server");
      }


    });
  }

  Future<bool> isIdInList({required int idVerbs}) async {
    bool valueReturn = false;
    await db.collection('personalList').doc(UUIDList).get().then((value) {
      late List<ListVerbsModel> ListVerb = value?['listIdVerbs'];
      for (var item in ListVerb) {
        if (item.id.toString() == idVerbs.toString()) {
          valueReturn = true;
        }
      }
    });
    return valueReturn;
  }

  Future<void> addInList({required idVerbs}) async {
    print('addInList');
   // Loader(context: context,snackBar: false).showLoader();
    print("add in liste: $idVerbs");
    List<ListVerbsModel> newListVerb = [];
    await db.collection('personalList').doc(UUIDList).get().then((value) {
        late List<ListVerbsModel> ListVerb = value?['listIdVerbs'];
          for (var item in ListVerb) {
            newListVerb.add(ListVerbsModel(id: item.id));
          }
        newListVerb.add(ListVerbsModel(id: idVerbs));
        print(newListVerb);
        Localstorelocal(context: context,ref: ref).updatePersonalList(UUIDList: UUIDList, titleList: titleList, colorList: colorList, listIdVerbs: newListVerb, isListShare: isListShare, ownListShare: ownListShare);
    });
   // await SnakBar(context: context, messageSnackBar: "Votre verbe est ajouté à votre liste", themeSnackBar: 'success').showSnakBar();
    form2Valide=true;

    //update data share
    print("update data share: addInList");
    await updataDataShare();


    Future.delayed(const Duration(milliseconds: 500),(){
    //  Loader(context: context, snackBar: false).hideLoader();
    });
  }

  Future<void> deleteInList({required idVerbs}) async {
   // Loader(context: context,snackBar: false).showLoader();
    print("delete in liste: $idVerbs");
    String StringVerbFrancais="";
    List<ListVerbsModel> newListVerb = [];
    await db.collection('personalList').doc(UUIDList).get().then((value) {
      form2Valide=false;
      late List<ListVerbsModel> ListVerb = value?['listIdVerbs'];
      for (var item in ListVerb) {
        if (item.id.toString() != idVerbs.toString()) {
          newListVerb.add(item);
          form2Valide=true;
        }
        else{
          StringVerbFrancais ="";
        }
      }
      Localstorelocal(context: context,ref: ref).updatePersonalList(UUIDList: UUIDList, titleList: titleList, colorList: colorList, listIdVerbs: newListVerb, isListShare: isListShare, ownListShare: ownListShare);
    });
   // await SnakBar(context: context, messageSnackBar: 'Votre verbe à été retiré de votre liste', themeSnackBar: 'success').showSnakBar();
    //update data share
    print("update data share: deleteInList");
    await updataDataShare();

    Future.delayed(const Duration(milliseconds: 500),(){
     // Loader(context: context, snackBar: false).hideLoader();
    });
  }

  Future<void> addOrDeleteInList({required idVerbs}) async {
      bool isInList = await isIdInList(idVerbs: idVerbs);
      if (isInList) {
        //delete
        print("**************deleteList");
        await deleteInList(idVerbs: idVerbs);
      } else {
        //add
        print("**************add");
        await addInList(idVerbs: idVerbs);
      };

      setState(() {

      });

  }


}





