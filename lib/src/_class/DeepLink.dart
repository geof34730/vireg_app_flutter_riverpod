import 'dart:convert';

import 'package:Vireg/src/_services/SharePersonalList.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../_models/PersonalListModel.dart';
import '../_utils/logger.dart';
import '../router.dart';
import 'Localstore.dart';

class DeepLink {
  DeepLink({
    required this.ref,
    required BuildContext this.context,
  });

  final WidgetRef ref;
  final BuildContext context;

  void initDeepLinks({required PendingDynamicLinkData? initialLink}) {
    Logger.Green.log("initDeepLinks Class");

    if (initialLink != null) {
      Logger.Red.log("************REDIRECT LOAD WITH PARAM DEEP LINK => ${initialLink.link.path} **************");
      customRoutesVireg.go(initialLink.link.path);
    }
    FirebaseDynamicLinks.instance.onLink.listen((deepLinkData) {
      final deepLink = deepLinkData.link;
      Logger.Magenta.log('Link received: $deepLink');
      Logger.Magenta.log("Redirect  listen deeplink ${deepLink.path}");
      customRoutesVireg.go(deepLink.path);
    }).onError((error) {
      Logger.Red.log('onLink error:');
      Logger.Red.log(error.message);
    });
  }

  Future<void> shareReceive({required String? personalListId }) async {
    Logger.Magenta.log("shareReceive $personalListId");
    SharePersonalList(context: context).GetList(idListPerso: personalListId).then((value)  async {
      PersonalListModel valueUpdate = value.copyWith(
        isListShare: true,
        );
      await  Localstorelocal(context:context,ref:ref).updateLocalstoreList(PersonalList: valueUpdate);
    });


  }

}