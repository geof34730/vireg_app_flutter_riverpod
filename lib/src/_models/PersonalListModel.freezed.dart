// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'PersonalListModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PersonalListModel _$PersonalListModelFromJson(Map<String, dynamic> json) {
  return _PersonalListModel.fromJson(json);
}

/// @nodoc
mixin _$PersonalListModel {
  int get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  int get color => throw _privateConstructorUsedError;
  List<dynamic> get listIdVerbs => throw _privateConstructorUsedError;
  bool get isListShare => throw _privateConstructorUsedError;
  bool get ownListShare => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PersonalListModelCopyWith<PersonalListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PersonalListModelCopyWith<$Res> {
  factory $PersonalListModelCopyWith(
          PersonalListModel value, $Res Function(PersonalListModel) then) =
      _$PersonalListModelCopyWithImpl<$Res, PersonalListModel>;
  @useResult
  $Res call(
      {int id,
      String title,
      int color,
      List<dynamic> listIdVerbs,
      bool isListShare,
      bool ownListShare});
}

/// @nodoc
class _$PersonalListModelCopyWithImpl<$Res, $Val extends PersonalListModel>
    implements $PersonalListModelCopyWith<$Res> {
  _$PersonalListModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? color = null,
    Object? listIdVerbs = null,
    Object? isListShare = null,
    Object? ownListShare = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int,
      listIdVerbs: null == listIdVerbs
          ? _value.listIdVerbs
          : listIdVerbs // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      isListShare: null == isListShare
          ? _value.isListShare
          : isListShare // ignore: cast_nullable_to_non_nullable
              as bool,
      ownListShare: null == ownListShare
          ? _value.ownListShare
          : ownListShare // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PersonalListModelImplCopyWith<$Res>
    implements $PersonalListModelCopyWith<$Res> {
  factory _$$PersonalListModelImplCopyWith(_$PersonalListModelImpl value,
          $Res Function(_$PersonalListModelImpl) then) =
      __$$PersonalListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String title,
      int color,
      List<dynamic> listIdVerbs,
      bool isListShare,
      bool ownListShare});
}

/// @nodoc
class __$$PersonalListModelImplCopyWithImpl<$Res>
    extends _$PersonalListModelCopyWithImpl<$Res, _$PersonalListModelImpl>
    implements _$$PersonalListModelImplCopyWith<$Res> {
  __$$PersonalListModelImplCopyWithImpl(_$PersonalListModelImpl _value,
      $Res Function(_$PersonalListModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? color = null,
    Object? listIdVerbs = null,
    Object? isListShare = null,
    Object? ownListShare = null,
  }) {
    return _then(_$PersonalListModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int,
      listIdVerbs: null == listIdVerbs
          ? _value._listIdVerbs
          : listIdVerbs // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
      isListShare: null == isListShare
          ? _value.isListShare
          : isListShare // ignore: cast_nullable_to_non_nullable
              as bool,
      ownListShare: null == ownListShare
          ? _value.ownListShare
          : ownListShare // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PersonalListModelImpl
    with DiagnosticableTreeMixin
    implements _PersonalListModel {
  const _$PersonalListModelImpl(
      {required this.id,
      required this.title,
      required this.color,
      required final List<dynamic> listIdVerbs,
      this.isListShare = false,
      this.ownListShare = false})
      : _listIdVerbs = listIdVerbs;

  factory _$PersonalListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PersonalListModelImplFromJson(json);

  @override
  final int id;
  @override
  final String title;
  @override
  final int color;
  final List<dynamic> _listIdVerbs;
  @override
  List<dynamic> get listIdVerbs {
    if (_listIdVerbs is EqualUnmodifiableListView) return _listIdVerbs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listIdVerbs);
  }

  @override
  @JsonKey()
  final bool isListShare;
  @override
  @JsonKey()
  final bool ownListShare;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'PersonalListModel(id: $id, title: $title, color: $color, listIdVerbs: $listIdVerbs, isListShare: $isListShare, ownListShare: $ownListShare)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'PersonalListModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('color', color))
      ..add(DiagnosticsProperty('listIdVerbs', listIdVerbs))
      ..add(DiagnosticsProperty('isListShare', isListShare))
      ..add(DiagnosticsProperty('ownListShare', ownListShare));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PersonalListModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.color, color) || other.color == color) &&
            const DeepCollectionEquality()
                .equals(other._listIdVerbs, _listIdVerbs) &&
            (identical(other.isListShare, isListShare) ||
                other.isListShare == isListShare) &&
            (identical(other.ownListShare, ownListShare) ||
                other.ownListShare == ownListShare));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      color,
      const DeepCollectionEquality().hash(_listIdVerbs),
      isListShare,
      ownListShare);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PersonalListModelImplCopyWith<_$PersonalListModelImpl> get copyWith =>
      __$$PersonalListModelImplCopyWithImpl<_$PersonalListModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PersonalListModelImplToJson(
      this,
    );
  }
}

abstract class _PersonalListModel implements PersonalListModel {
  const factory _PersonalListModel(
      {required final int id,
      required final String title,
      required final int color,
      required final List<dynamic> listIdVerbs,
      final bool isListShare,
      final bool ownListShare}) = _$PersonalListModelImpl;

  factory _PersonalListModel.fromJson(Map<String, dynamic> json) =
      _$PersonalListModelImpl.fromJson;

  @override
  int get id;
  @override
  String get title;
  @override
  int get color;
  @override
  List<dynamic> get listIdVerbs;
  @override
  bool get isListShare;
  @override
  bool get ownListShare;
  @override
  @JsonKey(ignore: true)
  _$$PersonalListModelImplCopyWith<_$PersonalListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
