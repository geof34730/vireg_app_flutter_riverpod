import 'package:Vireg/src/_models/PersonalListModel.dart';
import 'package:Vireg/src/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Vireg/src/localization/app_localizations_context.dart';

import '../_class/Localstore.dart';
import '../_class/localOnlineDevice.dart';
import '../_utils/string.dart';
import 'elevatedButtonCardHome.dart';
import 'elevatedButtonCardHomeEditDeleteShare.dart';
import 'package:ribbon_widget/ribbon_widget.dart';

class BoxCardListPerso extends ConsumerWidget {

  const BoxCardListPerso( {
    required this.context,
    required this.personalList,
    required this.onClickShare

  });
    final BuildContext context;
    final PersonalListModel personalList;
    final dynamic Function({required String idList}) onClickShare;

    @override
    Widget build(BuildContext context, WidgetRef ref) {
      return (personalList.isListShare && !personalList.ownListShare
          ?
          Ribbon(
            nearLength: 30.00,
            farLength: 60.00,
            title: 'partagée'.toUpperCase(),
            titleStyle: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold
            ),
            color: Colors.blue,
            child:boxCardChild(context: context,ref:ref,personalList:personalList,onClickShare:  onClickShare)
          )
          :
          boxCardChild(context: context,ref:ref,personalList:personalList,onClickShare:  onClickShare)
      );
    }
Card boxCardChild({required WidgetRef ref,  required BuildContext context,required PersonalListModel personalList, required dynamic onClickShare}){
        final localstoreLocalObj=Localstorelocal(ref: ref,context: context);
        int nbVerbsPerso=personalList.ListIdVerbs.length;
        return Card(
                shadowColor: Colors.grey,
                color: Color(personalList.color),
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
                                          capitalize(personalList.title),
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
                                          context.go('/learnVerb/${personalList.id}/true')
                                        }
                                    ),
                                    ElevatedButtonCardHome(
                                        label: context.loc.widgetBoxCardTest,
                                        iconContent: Icons.quiz,
                                        indexRubrique: 0,
                                        context: context,
                                        onClickButton: () => {
                                          context.go('/testVerb/${personalList.id}/true')
                                        }
                                    ),
                                    ElevatedButtonCardHome(
                                        label: context.loc.widgetBoxCardList,
                                        iconContent: Icons.visibility,
                                        indexRubrique: 2,
                                        context: context,
                                        onClickButton: () => {
                                          context.go('/listVerb/${personalList.id}/true')
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
                          ElevatedButtonCardHomeEditDeleteShare(visibilityButton:(nbVerbsPerso==0 ? false : true),
                              colorIcon: (ref.watch(localOnlineDeviceProvider) ? Colors.blue : Colors.grey),
                              iconContent: Icons.share, context: context,
                              onClickButton: () =>  {onClickShare.call(idList: personalList.id)}
                          ),
                          ElevatedButtonCardHomeEditDeleteShare(
                              visibilityButton: personalList.isListShare &&  !personalList.ownListShare ? false : true,
                              colorIcon: (personalList.ownListShare ? (ref.watch(localOnlineDeviceProvider) ? Colors.green : Colors.grey) : Colors.green),
                              iconContent: Icons.edit,
                              context: context,
                              onClickButton: () => {
                                context.go("/edit/ListPersoStep1/${personalList.id}")
                                }
                          ),
                          ElevatedButtonCardHomeEditDeleteShare(
                              colorIcon: (personalList.ownListShare ? (ref.watch(localOnlineDeviceProvider) ? Colors.red : Colors.grey) : Colors.red),
                              iconContent: Icons.delete, context: context,
                                  onClickButton: () => {
                                    localstoreLocalObj.deletePersonalList(
                                      personalList: personalList
                                    ),

                                  }
                            ),
                        ],
                      )
                    ],
                  )
              );

    }
}