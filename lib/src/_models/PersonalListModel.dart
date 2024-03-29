import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

import '../_utils/logger.dart';

part 'PersonalListModel.freezed.dart';
part 'PersonalListModel.g.dart';

PersonalListModel personalListModelFromJson(String str) => PersonalListModel.fromJson(json.decode(str));

PersonalListModel personalListModelFromResponseDio(Response response) => PersonalListModel.fromJson(jsonDecode(response.data["data"].toString()));

String personalListModelToJson(PersonalListModel data) => json.encode(data.toJson());

@freezed
class PersonalListModel with _$PersonalListModel {
  const factory PersonalListModel({
    required String id,
    required String title,
    required int color,
    @Default([]) List<ListIdVerb> ListIdVerbs,
    @Default(false) bool isListShare,
    @Default(false) bool ownListShare,
    @Default("") String urlShare
  }) = _PersonalListModel;
  factory PersonalListModel.fromJson(Map<String, dynamic> json) => _$PersonalListModelFromJson(json);
}


@freezed
class ListIdVerb with _$ListIdVerb {
  const factory ListIdVerb({
    required int id,
  }) = _ListIdVerb;

  factory ListIdVerb.fromJson(Map<String, dynamic> json) => _$ListIdVerbFromJson(json);
}

