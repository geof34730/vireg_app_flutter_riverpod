import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'src/app.dart';
import 'package:flutter/widgets.dart';



import 'package:localstorage/localstorage.dart';

final LocalStorage storageConfig =  new LocalStorage('config');


void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(ProviderScope(child: MyApp()));
}
