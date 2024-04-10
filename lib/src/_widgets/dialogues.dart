import 'package:Vireg/src/localization/app_localizations_context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:validators2/validators2.dart';

import '../_class/Loader.dart';
import '../_models/PersonalListModel.dart';
import '../_services/SharePersonalList.dart';


class Dialogues extends ConsumerWidget {


  const Dialogues({
    required BuildContext this.context,
    required String this.lang

  });

  final BuildContext context;
  final String lang;



  Future<String?> alertOffline() {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                    width:280.0,
                    child:Text(
                      context.loc.alertOffLine,
                      style: TextStyle(color: Colors.red, fontSize: 16.0),
                      textAlign: TextAlign.center,
                    )
                ),
                const SizedBox(height: 15, width: 150),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(context.loc.fermer),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> dialogBuilderShare({required PersonalListModel personalList }) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          //  scrollDirection: Axis.vertical,
            child: AlertDialog(
              insetPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              icon: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.end, children: [
                InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.close,
                    ))
              ]),
              title:  Text(
                context.loc.homeShareListTitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.00),
              ),
              content: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                SizedBox(
                    width: 360,
                    height: 40,
                    child: Text(
                      context.loc.homeShareListeDescription,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.00),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 10.00, bottom: 10.0),
                  child: Container(
                      width: 280,
                      height: 280,
                      color: Colors.blue,
                      child: QrImageView(
                        data: personalList.urlShare,
                        version: 10,
                        size: 280,
                        gapless: true,
                        backgroundColor: Colors.white,
                      )),
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      context.loc.homeShareListeOr,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18.00, fontWeight: FontWeight.bold),
                    )),
                Text(
                  context.loc.homeShareTitleChoiseSend,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.00),
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ElevatedButton.icon(
                          onPressed: () async {
                            sendQrCode(personalList: personalList);
                          },
                          icon: const Icon(
                            Icons.email,
                          ),
                          label: Text(
                            context.loc.homeShareButtonendByEmail,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )))
                ])
              ]),
            ));
      },
    );
  }

  Future<void> dialogBuilderShareEmail({required PersonalListModel personalList }) {
    final GlobalKey<FormState> _formKeyShareEmail = GlobalKey<FormState>();
    TextEditingController controllerPseudo = TextEditingController();
    TextEditingController controllerEmail = TextEditingController();

    bool activateButtonSendShareByEmail = true;
    bool errorSendShareByEMail = false;
    bool succesSendShareByEMail = false;
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return SingleChildScrollView(
              //  scrollDirection: Axis.vertical,
                child: AlertDialog(
                  insetPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  icon: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.end, children: [
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const Icon(
                          Icons.close,
                        ))
                  ]),
                  title: Text(
                    context.loc.sendListByMailTitle,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18.00),
                  ),
                  content: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                    Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                      Form(
                        key: _formKeyShareEmail,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                                width: 280,
                                child: TextFormField(
                                  controller: controllerPseudo..text,
                                  decoration: InputDecoration(
                                    hintText: context.loc.sendListByMailLabelTextPseudo,
                                    hintStyle: TextStyle(fontSize: 14.00),
                                    labelText: context.loc.sendListByMailLabelTextPseudo,
                                    labelStyle: TextStyle(fontSize: 14.00),
                                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.lightBlue)),
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.isEmpty) {
                                      return context.loc.sendListByMailLabelTextPseudo;
                                    }
                                    return null;
                                  },
                                )),
                            Padding(
                                padding: const EdgeInsets.only(top: 14.0),
                                child: SizedBox(
                                    width: 280,
                                    child: TextFormField(
                                      controller: controllerEmail..text,
                                      decoration: InputDecoration(
                                        hintText: context.loc.sendListByMailLabelTextEmail,
                                        hintStyle: const TextStyle(fontSize: 14.00),
                                        labelText: context.loc.sendListByMailLabelTextEmail,
                                        labelStyle: const TextStyle(fontSize: 14.00),
                                        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.lightBlue)),
                                        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(width: 2, color: Colors.lightBlue)),
                                        disabledBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(width: 2, color: Colors.green),
                                          borderRadius: BorderRadius.circular(5),
                                        ),
                                      ),
                                      validator: (String? value) {
                                        if (!isEmail(value!)) {
                                          return context.loc.sendListByMailLabelTextEmail;
                                        }
                                        return null;
                                      },
                                    ))),
                            Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: ElevatedButton.icon(
                                    onPressed: (activateButtonSendShareByEmail
                                        ? () {
                                      if (_formKeyShareEmail.currentState!.validate()) {
                                        activateButtonSendShareByEmail = false;
                                        setState(() {});
                                        Loader(context: context, snackBar: false).showLoader();
                                        SharePersonalList(context: context).sendShareByEMail(
                                          pseudo: controllerPseudo.text,
                                          email: controllerEmail.text,
                                          urlLinkShareFirebase: personalList.urlShare,
                                          listName: personalList.title,
                                          lang:lang
                                        ).then((value) async => {
                                          manageReturnShareByEmail(reponseCode: value["code"], controllerEmail: controllerEmail).then((value2) => {
                                            succesSendShareByEMail = value2,
                                            errorSendShareByEMail = !value2,
                                            activateButtonSendShareByEmail = true,
                                            setState(() {}),
                                            Future.delayed(const Duration(milliseconds: 3000), () {
                                              succesSendShareByEMail = false;
                                              errorSendShareByEMail = false;
                                              setState(() {});
                                            })
                                          },
                                          )
                                        });
                                      }
                                    }
                                        : null),
                                    icon: const Icon(
                                      Icons.send,
                                    ),
                                    label:  Text(
                                      context.loc.sendListByMailButton,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ))),
                            Visibility(
                              visible: succesSendShareByEMail,
                              child: Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    context.loc.sendListByMailConfirmation,
                                    style: TextStyle(color: Colors.green),
                                  )),
                            ),
                            Visibility(
                              visible: errorSendShareByEMail,
                              child:  Padding(
                                  padding: EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    context.loc.sendListByMailError,
                                    style: TextStyle(color: Colors.red),
                                  )),
                            )
                          ],
                        ),
                      ),
                    ])
                  ]),
                ));
          });
        });
  }

  void sendQrCode({required PersonalListModel personalList }) {
    Navigator.of(context).pop();
    dialogBuilderShareEmail(personalList: personalList);
  }

  Future<bool> manageReturnShareByEmail({required String reponseCode, required TextEditingController controllerEmail}) async {
    Loader(context: context, snackBar: false).hideLoader();
    if (reponseCode == "SBE2") {
      controllerEmail.text = "";
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    throw UnimplementedError();
  }


}




