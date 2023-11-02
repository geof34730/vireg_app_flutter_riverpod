// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PersonalListModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PersonalListModelImpl _$$PersonalListModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PersonalListModelImpl(
      id: json['id'] as int,
      title: json['title'] as String,
      color: json['color'] as int,
      listIdVerbs: json['listIdVerbs'] as List<dynamic>,
      isListShare: json['isListShare'] as bool? ?? false,
      ownListShare: json['ownListShare'] as bool? ?? false,
    );

Map<String, dynamic> _$$PersonalListModelImplToJson(
        _$PersonalListModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'color': instance.color,
      'listIdVerbs': instance.listIdVerbs,
      'isListShare': instance.isListShare,
      'ownListShare': instance.ownListShare,
    };
