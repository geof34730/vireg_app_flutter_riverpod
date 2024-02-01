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
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  int get color => throw _privateConstructorUsedError;
  List<ListIdVerb> get ListIdVerbs => throw _privateConstructorUsedError;
  bool get isListShare => throw _privateConstructorUsedError;
  bool get ownListShare => throw _privateConstructorUsedError;
  String? get urlShare => throw _privateConstructorUsedError;

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
      {String id,
      String title,
      int color,
      List<ListIdVerb> ListIdVerbs,
      bool isListShare,
      bool ownListShare,
      String? urlShare});
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
    Object? ListIdVerbs = null,
    Object? isListShare = null,
    Object? ownListShare = null,
    Object? urlShare = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int,
      ListIdVerbs: null == ListIdVerbs
          ? _value.ListIdVerbs
          : ListIdVerbs // ignore: cast_nullable_to_non_nullable
              as List<ListIdVerb>,
      isListShare: null == isListShare
          ? _value.isListShare
          : isListShare // ignore: cast_nullable_to_non_nullable
              as bool,
      ownListShare: null == ownListShare
          ? _value.ownListShare
          : ownListShare // ignore: cast_nullable_to_non_nullable
              as bool,
      urlShare: freezed == urlShare
          ? _value.urlShare
          : urlShare // ignore: cast_nullable_to_non_nullable
              as String?,
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
      {String id,
      String title,
      int color,
      List<ListIdVerb> ListIdVerbs,
      bool isListShare,
      bool ownListShare,
      String? urlShare});
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
    Object? ListIdVerbs = null,
    Object? isListShare = null,
    Object? ownListShare = null,
    Object? urlShare = freezed,
  }) {
    return _then(_$PersonalListModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      color: null == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as int,
      ListIdVerbs: null == ListIdVerbs
          ? _value._ListIdVerbs
          : ListIdVerbs // ignore: cast_nullable_to_non_nullable
              as List<ListIdVerb>,
      isListShare: null == isListShare
          ? _value.isListShare
          : isListShare // ignore: cast_nullable_to_non_nullable
              as bool,
      ownListShare: null == ownListShare
          ? _value.ownListShare
          : ownListShare // ignore: cast_nullable_to_non_nullable
              as bool,
      urlShare: freezed == urlShare
          ? _value.urlShare
          : urlShare // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PersonalListModelImpl implements _PersonalListModel {
  const _$PersonalListModelImpl(
      {required this.id,
      required this.title,
      required this.color,
      final List<ListIdVerb> ListIdVerbs = const [],
      this.isListShare = false,
      this.ownListShare = false,
      this.urlShare = null})
      : _ListIdVerbs = ListIdVerbs;

  factory _$PersonalListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PersonalListModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final int color;
  final List<ListIdVerb> _ListIdVerbs;
  @override
  @JsonKey()
  List<ListIdVerb> get ListIdVerbs {
    if (_ListIdVerbs is EqualUnmodifiableListView) return _ListIdVerbs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ListIdVerbs);
  }

  @override
  @JsonKey()
  final bool isListShare;
  @override
  @JsonKey()
  final bool ownListShare;
  @override
  @JsonKey()
  final String? urlShare;

  @override
  String toString() {
    return 'PersonalListModel(id: $id, title: $title, color: $color, ListIdVerbs: $ListIdVerbs, isListShare: $isListShare, ownListShare: $ownListShare, urlShare: $urlShare)';
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
                .equals(other._ListIdVerbs, _ListIdVerbs) &&
            (identical(other.isListShare, isListShare) ||
                other.isListShare == isListShare) &&
            (identical(other.ownListShare, ownListShare) ||
                other.ownListShare == ownListShare) &&
            (identical(other.urlShare, urlShare) ||
                other.urlShare == urlShare));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      color,
      const DeepCollectionEquality().hash(_ListIdVerbs),
      isListShare,
      ownListShare,
      urlShare);

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
      {required final String id,
      required final String title,
      required final int color,
      final List<ListIdVerb> ListIdVerbs,
      final bool isListShare,
      final bool ownListShare,
      final String? urlShare}) = _$PersonalListModelImpl;

  factory _PersonalListModel.fromJson(Map<String, dynamic> json) =
      _$PersonalListModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  int get color;
  @override
  List<ListIdVerb> get ListIdVerbs;
  @override
  bool get isListShare;
  @override
  bool get ownListShare;
  @override
  String? get urlShare;
  @override
  @JsonKey(ignore: true)
  _$$PersonalListModelImplCopyWith<_$PersonalListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ListIdVerb _$ListIdVerbFromJson(Map<String, dynamic> json) {
  return _ListIdVerb.fromJson(json);
}

/// @nodoc
mixin _$ListIdVerb {
  int get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ListIdVerbCopyWith<ListIdVerb> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListIdVerbCopyWith<$Res> {
  factory $ListIdVerbCopyWith(
          ListIdVerb value, $Res Function(ListIdVerb) then) =
      _$ListIdVerbCopyWithImpl<$Res, ListIdVerb>;
  @useResult
  $Res call({int id});
}

/// @nodoc
class _$ListIdVerbCopyWithImpl<$Res, $Val extends ListIdVerb>
    implements $ListIdVerbCopyWith<$Res> {
  _$ListIdVerbCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ListIdVerbImplCopyWith<$Res>
    implements $ListIdVerbCopyWith<$Res> {
  factory _$$ListIdVerbImplCopyWith(
          _$ListIdVerbImpl value, $Res Function(_$ListIdVerbImpl) then) =
      __$$ListIdVerbImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id});
}

/// @nodoc
class __$$ListIdVerbImplCopyWithImpl<$Res>
    extends _$ListIdVerbCopyWithImpl<$Res, _$ListIdVerbImpl>
    implements _$$ListIdVerbImplCopyWith<$Res> {
  __$$ListIdVerbImplCopyWithImpl(
      _$ListIdVerbImpl _value, $Res Function(_$ListIdVerbImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
  }) {
    return _then(_$ListIdVerbImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ListIdVerbImpl implements _ListIdVerb {
  const _$ListIdVerbImpl({required this.id});

  factory _$ListIdVerbImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListIdVerbImplFromJson(json);

  @override
  final int id;

  @override
  String toString() {
    return 'ListIdVerb(id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListIdVerbImpl &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ListIdVerbImplCopyWith<_$ListIdVerbImpl> get copyWith =>
      __$$ListIdVerbImplCopyWithImpl<_$ListIdVerbImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ListIdVerbImplToJson(
      this,
    );
  }
}

abstract class _ListIdVerb implements ListIdVerb {
  const factory _ListIdVerb({required final int id}) = _$ListIdVerbImpl;

  factory _ListIdVerb.fromJson(Map<String, dynamic> json) =
      _$ListIdVerbImpl.fromJson;

  @override
  int get id;
  @override
  @JsonKey(ignore: true)
  _$$ListIdVerbImplCopyWith<_$ListIdVerbImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
