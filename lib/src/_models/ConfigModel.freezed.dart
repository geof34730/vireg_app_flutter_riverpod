// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ConfigModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ConfigModel _$ConfigModelFromJson(Map<String, dynamic> json) {
  return _ConfigModel.fromJson(json);
}

/// @nodoc
mixin _$ConfigModel {
  String get lang => throw _privateConstructorUsedError;
  bool get onlineDevice => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConfigModelCopyWith<ConfigModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigModelCopyWith<$Res> {
  factory $ConfigModelCopyWith(
          ConfigModel value, $Res Function(ConfigModel) then) =
      _$ConfigModelCopyWithImpl<$Res, ConfigModel>;
  @useResult
  $Res call({String lang, bool onlineDevice});
}

/// @nodoc
class _$ConfigModelCopyWithImpl<$Res, $Val extends ConfigModel>
    implements $ConfigModelCopyWith<$Res> {
  _$ConfigModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lang = null,
    Object? onlineDevice = null,
  }) {
    return _then(_value.copyWith(
      lang: null == lang
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String,
      onlineDevice: null == onlineDevice
          ? _value.onlineDevice
          : onlineDevice // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConfigModelImplCopyWith<$Res>
    implements $ConfigModelCopyWith<$Res> {
  factory _$$ConfigModelImplCopyWith(
          _$ConfigModelImpl value, $Res Function(_$ConfigModelImpl) then) =
      __$$ConfigModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String lang, bool onlineDevice});
}

/// @nodoc
class __$$ConfigModelImplCopyWithImpl<$Res>
    extends _$ConfigModelCopyWithImpl<$Res, _$ConfigModelImpl>
    implements _$$ConfigModelImplCopyWith<$Res> {
  __$$ConfigModelImplCopyWithImpl(
      _$ConfigModelImpl _value, $Res Function(_$ConfigModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lang = null,
    Object? onlineDevice = null,
  }) {
    return _then(_$ConfigModelImpl(
      lang: null == lang
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String,
      onlineDevice: null == onlineDevice
          ? _value.onlineDevice
          : onlineDevice // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConfigModelImpl with DiagnosticableTreeMixin implements _ConfigModel {
  const _$ConfigModelImpl({required this.lang, this.onlineDevice = false});

  factory _$ConfigModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConfigModelImplFromJson(json);

  @override
  final String lang;
  @override
  @JsonKey()
  final bool onlineDevice;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ConfigModel(lang: $lang, onlineDevice: $onlineDevice)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ConfigModel'))
      ..add(DiagnosticsProperty('lang', lang))
      ..add(DiagnosticsProperty('onlineDevice', onlineDevice));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConfigModelImpl &&
            (identical(other.lang, lang) || other.lang == lang) &&
            (identical(other.onlineDevice, onlineDevice) ||
                other.onlineDevice == onlineDevice));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, lang, onlineDevice);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConfigModelImplCopyWith<_$ConfigModelImpl> get copyWith =>
      __$$ConfigModelImplCopyWithImpl<_$ConfigModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConfigModelImplToJson(
      this,
    );
  }
}

abstract class _ConfigModel implements ConfigModel {
  const factory _ConfigModel(
      {required final String lang,
      final bool onlineDevice}) = _$ConfigModelImpl;

  factory _ConfigModel.fromJson(Map<String, dynamic> json) =
      _$ConfigModelImpl.fromJson;

  @override
  String get lang;
  @override
  bool get onlineDevice;
  @override
  @JsonKey(ignore: true)
  _$$ConfigModelImplCopyWith<_$ConfigModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
