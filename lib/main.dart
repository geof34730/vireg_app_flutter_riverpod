
import 'package:Vireg/src/myApp.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'global.dart' as globals;
import 'package:url_strategy/url_strategy.dart';
import 'firebase_options.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'admanager_non_web_specific.dart' if (dart.library.html) 'admanager_web_specific.dart';
//import 'admanager_non_web_specific.dart' r;
Future<void> main() async {
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  globals.versionApp=packageInfo.version;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var initialLink;
  if (!kIsWeb) {
    MobileAds.instance.initialize();
    final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
  }
  if(kIsWeb){
    initializeAdManager();
  }
  runApp(ProviderScope(child:MyApp(initialLink:initialLink)));
}
