import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../_class/DataTableListeVerbes.dart';
import '../_class/GetDataVerbs.dart';
import '../_class/localLang.dart';
import '../_utils/front.dart';
import '../router.dart';


class ListVerb extends ConsumerStatefulWidget {
  const ListVerb({Key? key}) : super(key: key);
  @override
  _ListVerbState createState() => _ListVerbState();
}

class _ListVerbState extends ConsumerState<ListVerb> {
  final searchController = TextEditingController();
  List<dynamic> filteredData = [];
  List<dynamic> dataList=[];
  final keydataTable = GlobalKey<PaginatedDataTableState>();

  @override
  void initState() {
    print('initstat ListVerb');
    getListVerbsJson(typeListe: "top20");
    final  DataTableSource data = DataTableListeVerbes(filteredData: filteredData, context: context);
    super.initState();
  }

  @override
  void dispose() {
    searchController.text = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final  DataTableSource data = DataTableListeVerbes(filteredData: filteredData, context: context);

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
                            _onSearchTextChanged('');
                            keydataTable.currentState?.pageTo(0);
                          });
                        },
                      ),
                    )
                  : null),
          onChanged: _onSearchTextChanged,
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
                  child: const Text('Français', overflow: TextOverflow.ellipsis),
                ),
            ),
            DataColumn(
                label: ConstrainedBox(
                  constraints: constraintsDataColumn(flexNumber: 4), //SET max width
                  child: const Text('Infinitif (inf)\nPrétérit (ps)\nParticipe passé (pp)',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        height: 1.5,
                      )),
                )),
            DataColumn(
                label: ConstrainedBox(
                    constraints: constraintsDataColumn(flexNumber: 2), //SET max width
                    child: const Center(child:Text('Audios',
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

  void _onSearchTextChanged(String text) {
    setState(() {
      filteredData = text.isEmpty
          ? dataList
          : dataList
          .where((item) =>
          removeDiacritics(item['infinitif']).toLowerCase().contains(removeDiacritics(text).toLowerCase()) ||
          removeDiacritics(item['pastSimple']).toLowerCase().contains(removeDiacritics(text).toLowerCase()) ||
          removeDiacritics(item['pastParticipe']).toLowerCase().contains(removeDiacritics(text).toLowerCase()) ||
          removeDiacritics(item['francais']).toLowerCase().contains(removeDiacritics(text).toLowerCase()))
          .toList();
      keydataTable.currentState?.pageTo(0);
    });
  }

  List sortVerbsByFrancais(datas) {
    datas.sort((a, b) {
      return removeDiacritics(a['francais'])
          .toString()
          .toLowerCase()
          .compareTo(removeDiacritics(b['francais']).toString().toLowerCase());
    });
    return datas;
  }

  Future<void> getListVerbsJson({required String typeListe}) async {
    List<dynamic> dataListResp=await GetDataVerbs().getDataJson(typeListe: typeListe);
    dataList=dataListResp.toList();
    setState(() {
      dataList=dataListResp.toList();
      filteredData = sortVerbsByFrancais(dataList);
    });
  }

  Future<List<dynamic>> getdataList({required String typeListe}) async {
    List<dynamic> dataListResp=await GetDataVerbs().getDataJson(typeListe: typeListe);
    dataList=dataListResp.toList();
    return dataList;
  }

}
