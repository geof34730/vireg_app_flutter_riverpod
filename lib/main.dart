import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'src/app.dart';
import 'package:flutter/widgets.dart';






void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    runApp(ProviderScope(child: MyApp()));
}
