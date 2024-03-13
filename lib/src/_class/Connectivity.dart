import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../_utils/logger.dart';

enum ConnectivityStatus { NotDetermined, isConnected, isDisonnected }

class ConnectivityStatusNotifier extends StateNotifier<ConnectivityStatus> {
  StreamController<ConnectivityResult> controller = StreamController<ConnectivityResult>();

  ConnectivityStatus? lastResult;
  ConnectivityStatus? newState;
  ConnectivityStatusNotifier() : super(ConnectivityStatus.isConnected) {
    if (state == ConnectivityStatus.isConnected) {
      lastResult = ConnectivityStatus.isConnected;
    } else {
      lastResult = ConnectivityStatus.isDisonnected;
    }
    lastResult = ConnectivityStatus.NotDetermined;
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
     if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi ||
          result == ConnectivityResult.ethernet ||
          result == ConnectivityResult.vpn) {
            Logger.Green.log( "OK connection: ");
            newState = ConnectivityStatus.isConnected;
            //  ScaffoldMessenger.of(context).hideCurrentSnackBar();
      } else {
        Logger.Green.log( "NO connection: ");
        newState = ConnectivityStatus.isDisonnected;
      }
      if (newState != lastResult) {
        state = newState!;
        lastResult = newState;
      }
    });
  }
}

final connectivityStatusProviders = StateNotifierProvider((ref) {
  return ConnectivityStatusNotifier();
});






/*
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../_providers/localOnlineDevice.dart';
import '../_utils/logger.dart';
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
  late bool isOnline=false;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;



  Future<void> init() async {
    Logger.Yellow.log("init Class connectivity");
    initConnectivity().then((value) => {streamConectity()});
  }


  Future<void> initConnectivity() async {
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      Logger.Red.log('******************Couldn\'t check connectivity status:');
      //print('******************Couldn\'t check connectivity status: ', error: e);
      return;
    }
    if (!context.mounted) {
      Logger.Red.log("******************Context isn't mounted in connectivity Class");
      return Future.value(null);
    }
    Logger.Cyan.log("******************Go updateConnectionStatus");
    return updateConnectionStatus(result);
  }

  void streamConectity(){

    Logger.Yellow.log("streamConectity  Class connectivity");
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  void dispose(){
    Logger.Yellow.log("dispose  Class connectivity");
    _connectivitySubscription.cancel();
  }

  void updateConnectionStatus(ConnectivityResult connectivityResult)  {
    final objSnackBar=
    Logger.Yellow.log("updateConnectionStatus  Class connectivity");
    if(context.mounted) {
      Logger.Yellow.log("Mounted updateConnectionStatus  Class connectivity");
      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.ethernet ||
          connectivityResult == ConnectivityResult.vpn) {
        ref.read(localOnlineDeviceProvider.notifier).change(onlineDevice: true);
        //Logger.Green.log( "OK connection: ${ref.watch(localOnlineDeviceProvider)}");
        Logger.Green.log( "OK connection: ");
        objSnackBar.hideSnakBar();
        //  ScaffoldMessenger.of(context).hideCurrentSnackBar();
      } else {
        Future.delayed(const Duration(milliseconds: 100), () {
          ref.read(localOnlineDeviceProvider.notifier).change(onlineDevice: false);
        });
        Logger.Magenta.log("NO connection: ${ref.watch(localOnlineDeviceProvider)}");
        //Logger.Magenta.log("NO connection:");
          Future.delayed(const Duration(milliseconds: 100), () {
            objSnackBar.showSnakBar();
          });
      }
    }
    else{
      Logger.Yellow.log("NO Mounted updateConnectionStatus  Class connectivity");
    }
  }


}
*/




