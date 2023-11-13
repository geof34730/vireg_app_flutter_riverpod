import 'package:Vireg/src/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:Vireg/src/localization/app_localizations_context.dart';


import '../_class/DeepLink.dart';
import '../myApp.dart';



bool sendServer = false;

class Share extends ConsumerWidget {
  const Share({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {



if(!sendServer) {
  sendServer=true;
  WidgetsBinding.instance.addPostFrameCallback((_) {
    objDeeplinksInit.shareReceive(personalListId: GoRouterState
        .of(context)
        .pathParameters["personalListId"].toString()).then((value) {
      //Future.delayed(Duration(seconds: 2), () {
      // customRoutes.go("/");
      // context.go('/');
      customRoutes.goNamed('Home');
      Future.delayed(Duration(seconds: 1), () {
      sendServer=false;

       });
    });
  });
}
    print("build share");

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
      alignment: Alignment.center,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        LoadingAnimationWidget.dotsTriangle(
          color: Colors.blue,
          size: 150.0,
        ),
        Padding(
            padding: EdgeInsets.only(top: 10.0, left: 15.0, right: 30.0),
            child: Text(
              context.loc.shareLoadingListPersonal,
              textAlign: TextAlign.center,
            ))
      ]),
    );
  }
}
