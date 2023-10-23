import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'VerbsModel.freezed.dart';
part 'VerbsModel.g.dart';

@freezed
class VerbsModel with _$VerbsModel {
  const factory VerbsModel({
    required int id,
    required String fr,
    required String pastSimple,
    required String pastParticipe,
    required String infinitif,
  }) = _VerbsModel;

  factory VerbsModel.fromJson(Map<String, Object?> json) => _$VerbsModelFromJson(json);
}