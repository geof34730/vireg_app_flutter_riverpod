// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'VerbsModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VerbsModel _$VerbsModelFromJson(Map<String, dynamic> json) {
  return _VerbsModel.fromJson(json);
}

/// @nodoc
mixin _$VerbsModel {
  int get id => throw _privateConstructorUsedError;
  String get fr => throw _privateConstructorUsedError;
  String get pastSimple => throw _privateConstructorUsedError;
  String get pastParticipe => throw _privateConstructorUsedError;
  String get infinitif => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VerbsModelCopyWith<VerbsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerbsModelCopyWith<$Res> {
  factory $VerbsModelCopyWith(
          VerbsModel value, $Res Function(VerbsModel) then) =
      _$VerbsModelCopyWithImpl<$Res, VerbsModel>;
  @useResult
  $Res call(
      {int id,
      String fr,
      String pastSimple,
      String pastParticipe,
      String infinitif});
}

/// @nodoc
class _$VerbsModelCopyWithImpl<$Res, $Val extends VerbsModel>
    implements $VerbsModelCopyWith<$Res> {
  _$VerbsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fr = null,
    Object? pastSimple = null,
    Object? pastParticipe = null,
    Object? infinitif = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      fr: null == fr
          ? _value.fr
          : fr // ignore: cast_nullable_to_non_nullable
              as String,
      pastSimple: null == pastSimple
          ? _value.pastSimple
          : pastSimple // ignore: cast_nullable_to_non_nullable
              as String,
      pastParticipe: null == pastParticipe
          ? _value.pastParticipe
          : pastParticipe // ignore: cast_nullable_to_non_nullable
              as String,
      infinitif: null == infinitif
          ? _value.infinitif
          : infinitif // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VerbsModelImplCopyWith<$Res>
    implements $VerbsModelCopyWith<$Res> {
  factory _$$VerbsModelImplCopyWith(
          _$VerbsModelImpl value, $Res Function(_$VerbsModelImpl) then) =
      __$$VerbsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String fr,
      String pastSimple,
      String pastParticipe,
      String infinitif});
}

/// @nodoc
class __$$VerbsModelImplCopyWithImpl<$Res>
    extends _$VerbsModelCopyWithImpl<$Res, _$VerbsModelImpl>
    implements _$$VerbsModelImplCopyWith<$Res> {
  __$$VerbsModelImplCopyWithImpl(
      _$VerbsModelImpl _value, $Res Function(_$VerbsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fr = null,
    Object? pastSimple = null,
    Object? pastParticipe = null,
    Object? infinitif = null,
  }) {
    return _then(_$VerbsModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      fr: null == fr
          ? _value.fr
          : fr // ignore: cast_nullable_to_non_nullable
              as String,
      pastSimple: null == pastSimple
          ? _value.pastSimple
          : pastSimple // ignore: cast_nullable_to_non_nullable
              as String,
      pastParticipe: null == pastParticipe
          ? _value.pastParticipe
          : pastParticipe // ignore: cast_nullable_to_non_nullable
              as String,
      infinitif: null == infinitif
          ? _value.infinitif
          : infinitif // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VerbsModelImpl with DiagnosticableTreeMixin implements _VerbsModel {
  const _$VerbsModelImpl(
      {required this.id,
      required this.fr,
      required this.pastSimple,
      required this.pastParticipe,
      required this.infinitif});

  factory _$VerbsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerbsModelImplFromJson(json);

  @override
  final int id;
  @override
  final String fr;
  @override
  final String pastSimple;
  @override
  final String pastParticipe;
  @override
  final String infinitif;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'VerbsModel(id: $id, fr: $fr, pastSimple: $pastSimple, pastParticipe: $pastParticipe, infinitif: $infinitif)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'VerbsModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('fr', fr))
      ..add(DiagnosticsProperty('pastSimple', pastSimple))
      ..add(DiagnosticsProperty('pastParticipe', pastParticipe))
      ..add(DiagnosticsProperty('infinitif', infinitif));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerbsModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fr, fr) || other.fr == fr) &&
            (identical(other.pastSimple, pastSimple) ||
                other.pastSimple == pastSimple) &&
            (identical(other.pastParticipe, pastParticipe) ||
                other.pastParticipe == pastParticipe) &&
            (identical(other.infinitif, infinitif) ||
                other.infinitif == infinitif));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, fr, pastSimple, pastParticipe, infinitif);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$VerbsModelImplCopyWith<_$VerbsModelImpl> get copyWith =>
      __$$VerbsModelImplCopyWithImpl<_$VerbsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerbsModelImplToJson(
      this,
    );
  }
}

abstract class _VerbsModel implements VerbsModel {
  const factory _VerbsModel(
      {required final int id,
      required final String fr,
      required final String pastSimple,
      required final String pastParticipe,
      required final String infinitif}) = _$VerbsModelImpl;

  factory _VerbsModel.fromJson(Map<String, dynamic> json) =
      _$VerbsModelImpl.fromJson;

  @override
  int get id;
  @override
  String get fr;
  @override
  String get pastSimple;
  @override
  String get pastParticipe;
  @override
  String get infinitif;
  @override
  @JsonKey(ignore: true)
  _$$VerbsModelImplCopyWith<_$VerbsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
