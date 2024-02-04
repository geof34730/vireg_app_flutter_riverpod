// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ConfigModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConfigModelImpl _$$ConfigModelImplFromJson(Map<String, dynamic> json) =>
    _$ConfigModelImpl(
      lang: json['lang'] as String,
      onlineDevice: json['onlineDevice'] as bool? ?? false,
      versionapp: json['versionapp'] as String? ?? "",
    );

Map<String, dynamic> _$$ConfigModelImplToJson(_$ConfigModelImpl instance) =>
    <String, dynamic>{
      'lang': instance.lang,
      'onlineDevice': instance.onlineDevice,
      'versionapp': instance.versionapp,
    };
