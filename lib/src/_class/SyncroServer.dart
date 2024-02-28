import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../_models/PersonalListModel.dart';
import '../_providers/localOnlineDevice.dart';
import '../_services/SharePersonalList.dart';
import 'Loader.dart';
import 'Localstore.dart';



class SynchroServer {
  SynchroServer({
    required this.context,
    required this.ref
  });
  final BuildContext context;
  final WidgetRef ref;
  dynamic  LocalstorelocalObj;
  List listIdListShare = [];

  Future<bool> init() async{
    LocalstorelocalObj = Localstorelocal(context: context,ref: ref);
    await LocalstorelocalObj.getJsonAllPersonalistLocalStore().then((value)  async {
      await getListLocal(value);
      if (ref.watch(localOnlineDeviceProvider) ) {
        //Loader(context: context, snackBar: false).showLoader();
        await SharePersonalList(context: context).UpdateOrDeleteLoadListeShare(listIdListShare: listIdListShare).then((elementServer) async => {
        await deletePersonalist(elementServer: elementServer["data"]),
        await updatePersonalistLocal(elementServer: elementServer["data"])
          //Loader(context: context, snackBar: false).hideLoader()
        });

      }
    });
    return true;
  }

  Future<void> deletePersonalist({required dynamic elementServer}) async {
    LocalstorelocalObj.getJsonAllPersonalistLocalStore().then((valueLocal) {
      valueLocal.forEach((elementLocal)  {
        PersonalListModel elementLocalPersonalistModel = PersonalListModel.fromJson(elementLocal);
        if (elementLocalPersonalistModel.isListShare) {
          bool existInBdd = elementServer.toString().indexOf(elementLocalPersonalistModel.id) > 0;
          if (!existInBdd) {
            print("Delete: ${elementLocal['id']}");
            Localstorelocal(context: context,ref: ref).deletePersonalList(personalList: elementLocalPersonalistModel);
          }
          else{
            print("existe toujours en bdd: ${existInBdd.toString()}");
          }
        }
      });
    });
  }

  Future<void> updatePersonalistLocal({required dynamic elementServer}) async {
    elementServer.forEach((valueElementServer) async {
      await LocalstorelocalObj.getJsonAllPersonalistLocalStore().then((valueLocal)  async {
        valueLocal.forEach((elementvalueLocal) {
          if(elementvalueLocal['id']==jsonDecode(valueElementServer['data'])['id']){
            PersonalListModel PersonalistUpdateByServer = PersonalListModel
                .fromJson(jsonDecode(valueElementServer["data"])).copyWith(
                isListShare: elementvalueLocal["isListShare"],
                ownListShare: elementvalueLocal["ownListShare"]
            );
            LocalstorelocalObj.createPersonalList(PersonalList: PersonalistUpdateByServer);
          }
        });
      });
    });
  }

  Future<void> getListLocal(value) async {
    value.forEach((element) {
      if(element['isListShare']){
        listIdListShare.add(element['id']);
      }
    });
  }

}





