import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'localOnlineDevice.g.dart';

@riverpod
class localOnlineDevice extends _$localOnlineDevice {
  @override
  bool build() => false;

  void change({required bool onlineDevice}) {
    state = onlineDevice;
  }
}