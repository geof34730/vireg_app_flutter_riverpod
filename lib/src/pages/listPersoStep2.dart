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
import '../_class/Loader.dart';
import '../_class/Localstore.dart';
import '../_class/localLang.dart';
import '../_models/PersonalListModel.dart';
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
  late PersonalListModel PersonalListUpdate;

  @override
  void initState() {
    UUIDList=widget.idList.toString();
    print('initstat ListVerb');
    Localstorelocal(context: context,ref: ref).getJsonPersonalistLocalStore(idList: UUIDList).then((value){
      PersonalListUpdate=value;
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
      if(PersonalListUpdate.ownListShare) {
        print("go update server");
        SharePersonalList(context:context).Share(
            idListPerso: PersonalListUpdate.id,
            ListePerso:PersonalListUpdate
        );
      }
      else{
        print("NO go update server");
      }
  }

  Future<bool> isIdInList({required int idVerbs}) async {
      final data= PersonalListUpdate.ListIdVerbs.where((Verb) => (Verb.id==idVerbs));
      return  data.length>0;
  }

  Future<void> addInList({required idVerbs}) async {
    print("addInList: $idVerbs");
    PersonalListUpdate = PersonalListUpdate.copyWith(ListIdVerbs: [
        ...PersonalListUpdate.ListIdVerbs,
        ListIdVerb(id: idVerbs),
      ]);
    Localstorelocal(context: context,ref: ref).updatePersonalList(PersonalList: PersonalListUpdate);
    form2Valide=true;
    await updataDataShare();
  }

  Future<void> deleteInList({required idVerbs}) async {
    print("deleteInList: $idVerbs");
    String StringVerbFrancais="";
    form2Valide=false;
    PersonalListUpdate = PersonalListUpdate.copyWith(ListIdVerbs: [
        ...PersonalListUpdate.ListIdVerbs.where((element) => (element.id!=idVerbs))
      ]);
      StringVerbFrancais ="";
      Localstorelocal(context: context,ref: ref).updatePersonalList(PersonalList: PersonalListUpdate);
    await updataDataShare();
  }

  Future<void> addOrDeleteInList({required idVerbs}) async {
      print("addOrDeleteInList: $idVerbs");
      //Loader(context: context,snackBar: false).showLoader();
      bool isInList = await isIdInList(idVerbs: idVerbs);
      if (isInList) {
        await deleteInList(idVerbs: idVerbs);
        //await SnakBar(context: context, messageSnackBar: 'Votre verbe à été retiré de votre liste', themeSnackBar: 'success').showSnakBar();
      } else {
        await addInList(idVerbs: idVerbs);
        //await SnakBar(context: context, messageSnackBar: "Votre verbe est ajouté à votre liste", themeSnackBar: 'success').showSnakBar();
      };
      Future.delayed(const Duration(milliseconds: 500),(){
      //  Loader(context: context, snackBar: false).hideLoader();
      });
      setState(() {

      });
  }


}





