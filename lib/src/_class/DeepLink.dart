import 'dart:convert';

import 'package:Vireg/src/_services/SharePersonalList.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../_models/PersonalListModel.dart';
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
    print("initDeepLinks Cjass");

    if (initialLink != null) {
      print("************REDIRECT LOAD WITH PARAM DEEP LINK => ${initialLink.link.path} **************");
      context.go(initialLink.link.path);
    }
    FirebaseDynamicLinks.instance.onLink.listen((deepLinkData) {
      final deepLink = deepLinkData.link;
      print('Link received: $deepLink');
      print("Redirect  listen deeplink ${deepLink.path}");
      customRoutesVireg.go(deepLink.path);
    }).onError((error) {
      print('onLink error:');
      print(error.message);
    });
  }

  Future<void> shareReceive({required String? personalListId }) async {
    print("shareReceive $personalListId");
    SharePersonalList(context: context).GetList(idListPerso: personalListId).then((value)  async {
      PersonalListModel valueUpdate = value.copyWith(
        isListShare: true,
        );
      await  Localstorelocal(context:context,ref:ref).updateLocalstoreList(PersonalList: valueUpdate);
    });


  }

}