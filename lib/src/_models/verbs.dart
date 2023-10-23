import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'verbs.freezed.dart';
part 'verbs.g.dart';

@freezed
class Verbs with _$Verbs {
  const factory Verbs({
    required int id,
    required String fr,
    required String pastSimple,
    required String pastParticipe,
    required String infinitif,

  }) = _Verbs;

  factory Verbs.fromJson(Map<String, Object?> json)
  => _$VerbsFromJson(json);
}