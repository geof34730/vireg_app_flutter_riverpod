import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'PersonalListModel.freezed.dart';
part 'PersonalListModel.g.dart';

@freezed
class PersonalListModel with _$PersonalListModel {
  const factory PersonalListModel({
    required int id,
    required String title,
    required int color,
    required List listIdVerbs,
    @Default(false) bool isListShare,
    @Default(false) bool ownListShare,
  }) = _PersonalListModel;

  factory PersonalListModel.fromJson(Map<String, Object?> json) => _$PersonalListModelFromJson(json);
}