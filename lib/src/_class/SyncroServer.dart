import 'dart:async';
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../_models/PersonalListModel.dart';
import '../_providers/localOnlineDevice.dart';
import '../_services/SharePersonalList.dart';
import '../_utils/logger.dart';
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

  Future<List<dynamic>> init() async{
    LocalstorelocalObj = Localstorelocal(context: context,ref: ref);
    await LocalstorelocalObj.getJsonAllPersonalistLocalStore().then((value)  async {
      await getListLocal(value);
      if (ref.watch(localOnlineDeviceProvider) ) {
        //Loader(context: context, snackBar: false).showLoader();
        if(listIdListShare.length>0) {
          Logger.Green.log("******check list server");
          await SharePersonalList(context: context).UpdateOrDeleteLoadListeShare(listIdListShare: listIdListShare).then((elementServer) async =>
          {
            await deletePersonalist(elementServer: elementServer["data"]),
            await updatePersonalistLocal(elementServer: elementServer["data"]),
            //Loader(context: context, snackBar: false).hideLoader()
            Logger.Green.log("getJsonAllPersonalistLocalStore   ${LocalstorelocalObj.getJsonAllPersonalistLocalStore().toString()}"),
              await Future.delayed(const Duration(milliseconds: 100), () {
                Logger.Green.log('Pause for write localstore'); // Prints after 1 second.
              })
          });
        }
        else{
          Logger.Green.log("don't check list server");
        }
      }
    });
    return LocalstorelocalObj.getJsonAllPersonalistLocalStore();
  }

  Future<void> deletePersonalist({required dynamic elementServer}) async {
    LocalstorelocalObj.getJsonAllPersonalistLocalStore().then((valueLocal) {
      valueLocal.forEach((elementLocal)  {
        PersonalListModel elementLocalPersonalistModel = PersonalListModel.fromJson(elementLocal);
        if (elementLocalPersonalistModel.isListShare) {
          bool existInBdd = elementServer.toString().indexOf(elementLocalPersonalistModel.id) > 0;
          if (!existInBdd) {
            Logger.Green.log("Delete: ${elementLocal['id']}");
            if(!elementLocal['ownListShare']) {
              Localstorelocal(context: context, ref: ref).deletePersonalList(personalList: elementLocalPersonalistModel);
            }
          }
          else{
            Logger.Green.log("existe toujours en bdd: ${existInBdd.toString()}");
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
            Logger.White.log("********************************");
            Logger.Green.log(PersonalistUpdateByServer);
            Logger.White.log("********************************");
            LocalstorelocalObj.createPersonalList(PersonalList: PersonalistUpdateByServer);
          }
        });
      });
    });
  }

  Future<void> getListLocal(value) async {
    value.forEach((element) {
      if(element['isListShare'] && !element['ownListShare']){
        listIdListShare.add(element['id']);
      }
    });
  }

}





