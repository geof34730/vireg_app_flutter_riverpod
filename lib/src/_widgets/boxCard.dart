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
    this.isPersonnalList=false,
    required this.nbVerbsPerso,
    this.idListPerso = "",
    required String this.titleList
  });
    final BuildContext context;
    final Color colorsList;
    final bool isPersonnalList;

    final String titleList;
    final String idListPerso;
    final int nbVerbsPerso;

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
                      top: (isPersonnalList ? 0.00 : 5.00),
                      bottom: (nbVerbsPerso == 0 ? 0.0 : 5.0)
                  ),
                  child: Transform.translate(
                    offset: Offset(0, (isPersonnalList ? 5 : 0)),
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
                            Visibility(
                                visible: isPersonnalList,
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.only(left: 15.0, bottom: 5.0),
                                          child: Text(
                                            '(${nbVerbsPerso} verbe${((nbVerbsPerso >
                                                1) ? 's' : '')})',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12.0
                                            ),
                                          )
                                      )
                                    ]
                                )
                            )
                          ],),
                        subtitle:
                        (nbVerbsPerso == 0
                            ?
                        const Padding(
                            padding: EdgeInsets.only(top: 11.0, bottom: 12.0),
                            child: Text(
                              'Vous n\'avez pas de verbes dans cette liste\nAjoutez en, en modifiant la liste.',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            )
                        )
                            :
                        Wrap(
                          alignment: WrapAlignment.center,
                          verticalDirection: VerticalDirection.down,
                          spacing: 10.0,
                          // gap between adjacent chips
                          runSpacing: 10.0,
                          // gap between lines
                          children: [
                            ElevatedButtonCardHome(
                                label: context.loc.widgetBoxCardTest,
                                iconContent: Icons.quiz,
                                indexRubrique: 0,
                                context: context,
                                typeList: idListPerso,
                                onClickButton: () => {
                                  customRoutes.go('/testVerb/$idListPerso')
                                }
                            ),

                            ElevatedButtonCardHome(
                                label: context.loc.widgetBoxCardLearn,
                                iconContent: Icons.school,
                                indexRubrique: 1,
                                context: context,
                                typeList: idListPerso,
                                onClickButton: () => {
                                  customRoutes.go('/learnVerb/$idListPerso')
                                }
                            ),

                            ElevatedButtonCardHome(
                                label: context.loc.widgetBoxCardList,
                                iconContent: Icons.visibility,
                                indexRubrique: 2,
                                context: context,
                                typeList: idListPerso,
                                onClickButton: () => {
                                  customRoutes.go('/listVerb/$idListPerso')
                                }
                            ),
                          ],
                        )
                        )
                    ),
                  )),
              (isPersonnalList
                  ?
              /*Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButtonDeleteEdite(visibilityButton:(widget.nbVerbsPerso==0 ? false : true),colorIcon: Colors.blue, iconContent: Icons.share, context: context,
                      onClickButton: () => {widget.onClickShare.call(idPersonalList: idPersonalList, ListePerso: widget.ListePerso)}
                  ),
                  ElevatedButtonDeleteEdite(visibilityButton: widget.isListShare ? false : true,colorIcon: Colors.green, iconContent: Icons.edit, context: context,
                      onClickButton: () => {widget.onClickEdit.call(idPersonalList: idPersonalList,ownListShare:widget.ownListShare)}
                  ),
                  ElevatedButtonDeleteEdite(colorIcon: Colors.red, iconContent: Icons.delete, context: context,
                      onClickButton: () => {widget.onClickDelete.call(idPersonalList: idPersonalList,ownListShare:widget.ownListShare)}
                  ),
                ],
              )*/
              Text('ddd')
                  :
              const SizedBox()
              ),
            ],
          )
      );
    }
}