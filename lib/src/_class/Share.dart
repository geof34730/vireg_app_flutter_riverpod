

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../_models/PersonalListModel.dart';
import '../_services/SharePersonalList.dart';
import 'Loader.dart';
import 'Localstore.dart';

class Share{
  late BuildContext context;
  late WidgetRef ref;

  Share({
    required this.context,
    required this.ref
  });



  Future<void> shareListPerso({required PersonalListModel personalList}) async {
    Loader(context: context, snackBar: false).showLoader();
    if(personalList.urlShare=="") {
      SharePersonalList(context: context).Share(personalList: personalList).then((value) async {
        value = await value.copyWith(isListShare: true,ownListShare: true);
        await Localstorelocal(context: context, ref: ref).updatePersonalList(PersonalList: value);
        _dialogBuilderShare(context: context, personalList: value);
      //  setState(() {

       // });
        Loader(context: context, snackBar: false).hideLoader();
      });
    }
    else{
      _dialogBuilderShare(context: context, personalList: personalList);
      Loader(context: context, snackBar: false).hideLoader();
    }
  }

  void sendQrCode({required BuildContext context,required PersonalListModel personalList }) {
    Navigator.of(context).pop();
    _dialogBuilderShare(context: context,personalList: personalList);
  }

  Future<void> _dialogBuilderShare({required BuildContext context,required PersonalListModel personalList }) {
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
              title: const Text(
                'Partager votre liste personnalisée',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.00),
              ),
              content: Column(mainAxisSize: MainAxisSize.min, mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                const SizedBox(
                    width: 360,
                    height: 40,
                    child: Text(
                      'En faisant scanner le QR code ci-dessous à la personne avec qui vous souhaitez partager cette liste',
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
                const Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: Text(
                      'OU',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18.00, fontWeight: FontWeight.bold),
                    )),
                const Text(
                  'En envoyant le QR code de votre liste par email',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14.00),
                ),
                Row(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center, children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: ElevatedButton.icon(
                          onPressed: () async {
                            sendQrCode(context: context,personalList: personalList);
                          },
                          icon: const Icon(
                            Icons.email,
                          ),
                          label: const Text(
                            "Partager par email",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )))
                ])
              ]),
            ));
      },
    );
  }





}

