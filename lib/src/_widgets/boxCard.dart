import 'package:Vireg/src/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Vireg/src/localization/app_localizations_context.dart';

import '../_utils/string.dart';
import 'elevatedButtonCardHome.dart';

class BoxCard extends ConsumerWidget {
  const BoxCard({
    required BuildContext this.context,
    required this.colorsList,
    this.idListPerso = "",
    required String this.titleList
  });
    final BuildContext context;
    final Color colorsList;
    final String titleList;
    final String idListPerso;

    @override
    Widget build(BuildContext context, WidgetRef ref) {
      return Card(
          shadowColor: Colors.grey,
          color: colorsList,
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      left: 0.0,
                      right: 0.0,
                      top:  5.00,
                      bottom: 5.0
                  ),
                  child: Transform.translate(
                    offset: Offset(0,  0),
                    child: ListTile(
                        title: Column(
                          children: [
                            Padding(
                            padding: const EdgeInsets.only( bottom: 5.0),
                            child:Text(
                                capitalize(titleList),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.sourceSans3(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      height: 1.3,
                                      fontWeight: FontWeight.bold,
                                    )
                                  )
                                ),
                            ),
                          ],),
                        subtitle: Wrap(
                          alignment: WrapAlignment.center,
                          verticalDirection: VerticalDirection.down,
                          spacing: 10.0,
                          // gap between adjacent chips
                          runSpacing: 10.0,
                          // gap between lines
                          children: [
                            ElevatedButtonCardHome(
                                label: context.loc.widgetBoxCardLearn,
                                iconContent: Icons.school,
                                indexRubrique: 1,
                                context: context,
                                onClickButton: () => {
                                  context.go('/learnVerb/$idListPerso/false')
                                }
                            ),
                            ElevatedButtonCardHome(
                                label: context.loc.widgetBoxCardTest,
                                iconContent: Icons.quiz,
                                indexRubrique: 0,
                                context: context,
                                onClickButton: () => {
                                  context.go('/testVerb/$idListPerso/false')
                                }
                            ),
                            ElevatedButtonCardHome(
                                label: context.loc.widgetBoxCardList,
                                iconContent: Icons.visibility,
                                indexRubrique: 2,
                                context: context,
                                onClickButton: () => {
                                  context.go('/listVerb/$idListPerso/false')
                                }
                            ),
                          ],
                        )
                    ),
                  )),
            ],
          )
      );
    }
}