import 'package:flutter/material.dart';
import '../_utils/front.dart';
import '../_utils/string.dart';
import 'PlaySoond.dart';


class DataTableListeVerbes extends DataTableSource {
  final List<dynamic> filteredData;
  final BuildContext context;
  final String localLang;
  DataTableListeVerbes({
    required this.filteredData,
    required this.context,
    required this.localLang
  });

  bool loopMapFilter = false;

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
          DataCell( ConstrainedBox(
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
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            PlaySoond(dataVerbe:filteredData[index],typeAudio: "all",sizeIcon: 30,buttonColor: Colors.green).buttonPlay(),
                            ]
                        )
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
