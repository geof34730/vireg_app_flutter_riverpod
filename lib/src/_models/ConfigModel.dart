import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'ConfigModel.freezed.dart';
part 'ConfigModel.g.dart';

@freezed
class ConfigModel with _$ConfigModel {
  const factory ConfigModel({
    required String lang,
    @Default(false) bool onlineDevice,
    @Default("") String versionapp,

  }) = _ConfigModel;

  factory ConfigModel.fromJson(Map<String, Object?> json) => _$ConfigModelFromJson(json);
}