import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'localLang.g.dart';

@riverpod
class localLang extends _$localLang {
  @override
  String build() => "fr";

  void change({required String lang}) {
    state = lang;
  }
}
