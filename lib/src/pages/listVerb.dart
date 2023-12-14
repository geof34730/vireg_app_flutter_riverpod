import 'package:Vireg/src/localization/app_localizations_context.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../_Utils/string.dart';
import '../_class/DataTableListeVerbes.dart';
import '../_class/GetDataVerbs.dart';
import '../_class/localLang.dart';
import '../_utils/front.dart';
import '../router.dart';


class ListVerb extends ConsumerStatefulWidget {
  const ListVerb({Key? key, required this.idList}) : super(key: key);
  final String? idList;
  @override
  _ListVerbState createState() => _ListVerbState();
}

class _ListVerbState extends ConsumerState<ListVerb> {

  final searchController = TextEditingController();
  List<dynamic> filteredData = [];
  List<dynamic> dataList=[];
  final keydataTable = GlobalKey<PaginatedDataTableState>();
  String locallang="";


  @override
  void initState() {
    print('initstat ListVerb');
    getListVerbsJson(idList: widget.idList.toString());
    DataTableSource data = DataTableListeVerbes(filteredData: filteredData, context: context,localLang: locallang);
    super.initState();
  }

  @override
  void dispose() {
    searchController.text = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    locallang=ref.watch(localLangProvider);
    late DataTableSource data = DataTableListeVerbes(filteredData: filteredData, context: context,localLang: ref.watch(localLangProvider));
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
        child:PaginatedDataTable(
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
          source: data,
        ),
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

  Future<void> getListVerbsJson({required String idList}) async {
    List<dynamic> dataListResp=await GetDataVerbs().getDataJson(idList: idList);
    dataList=dataListResp.toList();
    setState(() {
      dataList=dataListResp.toList();
      filteredData = sortVerbsByFrancais(dataList);
    });
  }



}
