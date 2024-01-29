import 'package:Vireg/src/_models/PersonalListModel.dart';
import 'package:Vireg/src/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Vireg/src/localization/app_localizations_context.dart';

import '../_class/Localstore.dart';
import '../_utils/string.dart';
import 'elevatedButtonCardHome.dart';
import 'elevatedButtonCardHomeEditDeleteShare.dart';

class BoxCardListPerso extends ConsumerWidget {

  const BoxCardListPerso( {
    required BuildContext this.context,
    required String this.idListPerso,
    required this.onClickShare

  });
    final BuildContext context;
    final String idListPerso;
    final dynamic Function({required String idList}) onClickShare;

    @override
    Widget build(BuildContext context, WidgetRef ref) {
      final localstoreLocalObj=Localstorelocal(ref: ref,context: context);
      print("*********************************$idListPerso");
      Future<PersonalListModel> _futureDataListPerso() =>  localstoreLocalObj.getJsonPersonalistLocalStore(idList: idListPerso);
      return FutureBuilder<PersonalListModel>(
        future: _futureDataListPerso(),
        builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return const Text('Error');
                } else if (snapshot.hasData) {

                    print("*************dddddddd");
                    print(snapshot.data);

                    int nbVerbsPerso=snapshot.data!.ListIdVerbs.length;
                    return Card(
                        shadowColor: Colors.grey,
                        color: Color(snapshot.data!.color),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child:Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                  padding: EdgeInsets.only(
                                      left: 0.0,
                                      right: 0.0,
                                      top: 0.00,
                                      bottom: (nbVerbsPerso == 0 ? 0.0 : 5.0)
                                  ),
                                  child: Transform.translate(
                                    offset: Offset(0, 5),
                                    child: ListTile(
                                        title: Column(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only( bottom: 5.0),
                                              child:Text(
                                                  capitalize(snapshot.data!.title),
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
                                             Row(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Padding(
                                                        padding: const EdgeInsets.only(left: 15.0, bottom: 5.0),
                                                        child: Text(
                                                          '(${nbVerbsPerso} ${((nbVerbsPerso > 1) ? context.loc.boxCardVerbePluriel : context.loc.boxCardVerbeSingulier)})',
                                                          style: const TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 12.0
                                                          ),
                                                        )
                                                    )
                                                  ]
                                              )

                                          ],),
                                        subtitle:
                                        (nbVerbsPerso == 0
                                            ?
                                         Padding(
                                            padding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                                            child: Text(
                                             context.loc.boxCardListePersoAllerteNoVerbs,
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
                                                label: context.loc.widgetBoxCardLearn,
                                                iconContent: Icons.school,
                                                indexRubrique: 1,
                                                context: context,
                                                onClickButton: () => {
                                                  context.go('/learnVerb/${snapshot.data!.id}/true')
                                                }
                                            ),
                                            ElevatedButtonCardHome(
                                                label: context.loc.widgetBoxCardTest,
                                                iconContent: Icons.quiz,
                                                indexRubrique: 0,
                                                context: context,
                                                onClickButton: () => {
                                                  context.go('/testVerb/${snapshot.data!.id}/true')
                                                }
                                            ),
                                            ElevatedButtonCardHome(
                                                label: context.loc.widgetBoxCardList,
                                                iconContent: Icons.visibility,
                                                indexRubrique: 2,
                                                context: context,
                                                onClickButton: () => {
                                                  context.go('/listVerb/${snapshot.data!.id}/true')
                                                }
                                            ),
                                          ],
                                        )
                                        )
                                    ),
                                  )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButtonCardHomeEditDeleteShare(visibilityButton:(nbVerbsPerso==0 ? false : true),colorIcon: Colors.blue, iconContent: Icons.share, context: context,
                                      onClickButton: () =>  {onClickShare.call(idList: snapshot.data!.id)}
                                  ),
                                  ElevatedButtonCardHomeEditDeleteShare(visibilityButton: snapshot.data!.isListShare ? false : true,colorIcon: Colors.green, iconContent: Icons.edit, context: context,
                                      onClickButton: () => {
                                        context.go("/edit/ListPersoStep1/${snapshot.data!.id}")
                                        }
                                  ),
                                  ElevatedButtonCardHomeEditDeleteShare(colorIcon: Colors.red, iconContent: Icons.delete, context: context,
                                      onClickButton: () => {
                                        localstoreLocalObj.deletePersonalList(
                                          idPersonalList: snapshot.data!.id
                                        )
                                      }
                                  ),
                                ],
                              )
                            ],
                          )
                      );
                } else {
                  return const Text('Empty data');
                }
              } else {
                return Text('State: ${snapshot.connectionState}');
              }
        });











    }
}