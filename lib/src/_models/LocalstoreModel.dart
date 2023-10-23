import 'package:Vireg/src/_models/ConfigModel.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'LocalstoreModel.freezed.dart';
part 'LocalstoreModel.g.dart';

@freezed
class LocalstoreModel with _$LocalstoreModel {
  const factory LocalstoreModel({
    required ConfigModel config,
  }) = _LocalstoreModel;

  factory LocalstoreModel.fromJson(Map<String, Object?> json)
  => _$LocalstoreModelFromJson(json);
}