import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../router.dart';

class deepLink {
  deepLink({
    required this.ref,
    required BuildContext this.context,
  });

  final WidgetRef ref;
  final BuildContext context;

  void initDeepLinks({required PendingDynamicLinkData? initialLink}) {
    if (initialLink != null) {
      print("************REDIRECT LOAD WITH PARAM DEEP LINK => ${initialLink.link.path}");
      customRoutes.go(initialLink.link.path);
    }
    FirebaseDynamicLinks.instance.onLink.listen((deepLinkData) {
      final deepLink = deepLinkData.link;
      print('Link received: $deepLink');
      customRoutes.go(deepLink.path);
    }).onError((error) {
      print('onLink error:');
      print(error.message);
    });
  }

  Future<void> shareReceive({required String personalListId }) async {


    print("shareReceive $personalListId");




  }

}