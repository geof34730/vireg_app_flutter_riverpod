import 'package:Vireg/src/router.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:Vireg/src/localization/app_localizations_context.dart';
import 'package:url_launcher/url_launcher.dart';


import '../_Utils/string.dart';
import '../_class/DeepLink.dart';
import '../_utils/logger.dart';
import '../myApp.dart';
import 'dart:io' show Platform;

class Update extends ConsumerStatefulWidget {
  const Update({Key? key }) : super(key: key);

  @override
  _ShareState createState() => _ShareState();
}

class _ShareState extends ConsumerState<Update> {
  @override
  void initState() {
    Logger.Green.log("initState Update");

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  late dynamic urlPlatform = "";
  @override
  Widget build(BuildContext context) {
    Logger.Green.log("build Update");
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height-180  ,
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [

          Text(
              context.loc.updateAppMessage,
              textAlign: TextAlign.center,
              style:TextStyle(
                  fontWeight: FontWeight.bold
              )
          ),
          Padding(
              padding: EdgeInsets.only(top:20.00),
              child:ElevatedButton(
              onPressed: () async{
                var platformName = '';
                if (kIsWeb) {
                  platformName = "Web";
                } else {
                  if (Platform.isAndroid) {
                    urlPlatform = 'https://play.google.com/store/apps/details?id=verbeirregulieranglais.com.example.verbe_irregulier_anglais';
                    platformName = "Android";
                  } else if (Platform.isIOS) {
                    urlPlatform = 'https://apps.apple.com/us/app/vireg/id6446082557';
                    platformName = "IOS";
                  } else if (Platform.isFuchsia) {
                    platformName = "Fuchsia";
                  } else if (Platform.isLinux) {
                    platformName = "Linux";
                  } else if (Platform.isMacOS) {
                    platformName = "MacOS";
                  } else if (Platform.isWindows) {
                    platformName = "Windows";
                  }
                }
                print("platformName :- "+platformName.toString());
                if(urlPlatform!="") {
                  final url = Uri.parse(urlPlatform);
                  if (await canLaunchUrl(url)) {
                    launchUrl(url, mode: LaunchMode.externalApplication);
                  }
                }
            },
              child: Text(
                  context.loc.updateButton.toUpperCase(),
                style:TextStyle(
                  fontWeight: FontWeight.bold
                )

              )
          )
          ),

        ],
      ),

    );
  }

  Future<void> mylaunchUrl({required Uri url}) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
