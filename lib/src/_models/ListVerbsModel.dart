import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'ListVerbsModel.freezed.dart';
part 'ListVerbsModel.g.dart';

@freezed
class ListVerbsModel with _$ListVerbsModel {
  const factory ListVerbsModel({
    required int id,
  }) = _ListVerbsModel;

  factory ListVerbsModel.fromJson(Map<String, Object?> json) => _$ListVerbsModelFromJson(json);
}