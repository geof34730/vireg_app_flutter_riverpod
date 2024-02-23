




import 'package:Vireg/src/_models/PersonalListModel.dart';
import 'package:flutter/material.dart';

import '../_Utils/string.dart';
import '../_utils/front.dart';


class DataTableListeVerbesPersoAction extends DataTableSource {
  final List<dynamic> filteredData;
  final BuildContext context;
  final String localLang;
  Set<Future<void>> Function({required dynamic idVerbs}) addOrDeleteInList;
  final PersonalListModel PersonalListUpdate;

  DataTableListeVerbesPersoAction({
    required this.filteredData,
    required this.context,
    required this.addOrDeleteInList,
    required this.localLang,
    required this.isOnline,
    required this.PersonalListUpdate
  });
  bool isOnline;
  bool loopMapFilter = false;
  List<dynamic> ListPerso = [];


  @override
  DataRow? getRow(int index) {

    return DataRow(
        color: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
          if (loopMapFilter) {
            loopMapFilter = false;
            return Colors.grey.withOpacity(0.3);
          } else {
            loopMapFilter = true;
            return Colors.white;
          }
        }),
        cells: [
          DataCell(ConstrainedBox(
            constraints: BoxConstraints(
            minWidth: ResponsiveContent(context: context).choseSize(
              mobileSize: ResponsiveContent(context: context).sizeFlex(flexNumber: 4),
              otherSize:  ResponsiveContent(context: context).sizeFlex(flexNumber: 4),
            ),
            maxWidth: ResponsiveContent(context: context).choseSize(
            mobileSize: ResponsiveContent(context: context).sizeFlex(flexNumber: 4),
            otherSize:  ResponsiveContent(context: context).sizeFlex(flexNumber: 4),
            )
            ), //SET max width
            child: Text(
                        toTitleCase(filteredData[index][localLang].toString()),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: const TextStyle(
                          fontSize: 12.0
                        ),
                    ),
          )

          ),
          DataCell(
              ConstrainedBox(
                    constraints: BoxConstraints(
                      minWidth: ResponsiveContent(context: context).choseSize(
                      mobileSize: ResponsiveContent(context: context).sizeFlex(flexNumber: 4),
                      otherSize:  ResponsiveContent(context: context).sizeFlex(flexNumber: 4),
                      ),
                      maxWidth: ResponsiveContent(context: context).choseSize(
                      mobileSize: ResponsiveContent(context: context).sizeFlex(flexNumber: 4),
                      otherSize:  ResponsiveContent(context: context).sizeFlex(flexNumber: 4),
                      )
    ), //SET max width
    child: Padding(
              padding: const EdgeInsets.only(top:0,bottom:0),
              child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:[
                      Text(
                          "(inf) ${toTitleCase(filteredData[index]['infinitif'].toString())}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: const TextStyle(
                            fontSize: 12.0
                          ),
                      ),
                      Text(
                          "(ps) ${toTitleCase(filteredData[index]['pastSimple'].toString())}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: const TextStyle(
                            fontSize: 12.0
                          ),
                      ),
                      Text(
                          "(pp) ${toTitleCase(filteredData[index]['pastParticipe'].toString())}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: const TextStyle(
                            fontSize: 12.0
                          ),
                      ),
                   ]
              ),
    )
          )),
          DataCell(
             Center(
                child:CircleAvatar(
                      radius: 30,
                      backgroundColor: (PersonalListUpdate.ownListShare ? (isOnline ?  (filteredData[index]['isInListPerso'] ? Colors.red : Colors.green): Colors.grey) :(filteredData[index]['isInListPerso'] ? Colors.red : Colors.green)),
                      child: IconButton(
                        icon: Icon(
                          filteredData[index]['isInListPerso']  ? Icons.remove : Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          filteredData[index]['isInListPerso']=!filteredData[index]['isInListPerso'];
                          print(filteredData[index]['isInListPerso']);
                          addOrDeleteInList.call(idVerbs:filteredData[index]['id'] );
                        },
                      ),
                    ),
             )

          ),
        ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => filteredData.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
