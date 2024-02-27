import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../_providers/localOnlineDevice.dart';
import 'SnackBar.dart';

class ConectivityVireg {

  ConectivityVireg({
    required this.context,
    required this.ref
  });
  final BuildContext context;
  final WidgetRef ref;

  final Connectivity _connectivity = Connectivity();
  late ConnectivityResult result;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  late bool isOnline=false;


  void init(){
    initConnectivity();
    streamConectity();
  }


  Future<void> initConnectivity() async {
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print('******************Couldn\'t check connectivity status:');
      //print('******************Couldn\'t check connectivity status: ', error: e);
      return;
    }
   // if (!mounted) {
     // return Future.value(null);
   // }
    return updateConnectionStatus(result);
  }

  void streamConectity(){
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }


  void updateConnectionStatus(ConnectivityResult connectivityResult)  {
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.ethernet || connectivityResult == ConnectivityResult.vpn) {
      ref.read(localOnlineDeviceProvider.notifier).change(onlineDevice: true);
      print("OK connection: ${ref.watch(localOnlineDeviceProvider)}" );
      if(!isOnline) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        isOnline=true;
      }
    } else {
      ref.read(localOnlineDeviceProvider.notifier).change(onlineDevice: false);
      print("NO connection: ${ref.watch(localOnlineDeviceProvider)}" );
      if(isOnline) {
        SnakBar(context: context, messageSnackBar: "Vous êtes hors ligne",themeSnackBar: 'error',duration:3600).showSnakBar();
        isOnline=false;
      }
    }
    // setState(() {
    // });
  }


}





