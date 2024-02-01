// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PersonalListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PersonalListModelImpl _$$PersonalListModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PersonalListModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      color: json['color'] as int,
      ListIdVerbs: (json['ListIdVerbs'] as List<dynamic>?)
              ?.map((e) => ListIdVerb.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isListShare: json['isListShare'] as bool? ?? false,
      ownListShare: json['ownListShare'] as bool? ?? false,
      urlShare: json['urlShare'] as String? ?? null,
    );

Map<String, dynamic> _$$PersonalListModelImplToJson(
        _$PersonalListModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'color': instance.color,
      'ListIdVerbs': instance.ListIdVerbs,
      'isListShare': instance.isListShare,
      'ownListShare': instance.ownListShare,
      'urlShare': instance.urlShare,
    };

_$ListIdVerbImpl _$$ListIdVerbImplFromJson(Map<String, dynamic> json) =>
    _$ListIdVerbImpl(
      id: json['id'] as int,
    );

Map<String, dynamic> _$$ListIdVerbImplToJson(_$ListIdVerbImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
    };
