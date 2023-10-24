import 'package:Vireg/src/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child:MyApp()));
}
