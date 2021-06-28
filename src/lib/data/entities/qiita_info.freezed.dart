// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'qiita_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
QiitaInfo _$QiitaInfoFromJson(Map<String, dynamic> json) {
  return _QiitaInfo.fromJson(json);
}

/// @nodoc
class _$QiitaInfoTearOff {
  const _$QiitaInfoTearOff();

// ignore: unused_element
  _QiitaInfo call(
      {String title, String url, @JsonKey(name: 'user') QiitaUser qiitaUser}) {
    return _QiitaInfo(
      title: title,
      url: url,
      qiitaUser: qiitaUser,
    );
  }

// ignore: unused_element
  QiitaInfo fromJson(Map<String, Object> json) {
    return QiitaInfo.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $QiitaInfo = _$QiitaInfoTearOff();

/// @nodoc
mixin _$QiitaInfo {
  String get title;
  String get url;
  @JsonKey(name: 'user')
  QiitaUser get qiitaUser;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $QiitaInfoCopyWith<QiitaInfo> get copyWith;
}

/// @nodoc
abstract class $QiitaInfoCopyWith<$Res> {
  factory $QiitaInfoCopyWith(QiitaInfo value, $Res Function(QiitaInfo) then) =
      _$QiitaInfoCopyWithImpl<$Res>;
  $Res call(
      {String title, String url, @JsonKey(name: 'user') QiitaUser qiitaUser});

  $QiitaUserCopyWith<$Res> get qiitaUser;
}

/// @nodoc
class _$QiitaInfoCopyWithImpl<$Res> implements $QiitaInfoCopyWith<$Res> {
  _$QiitaInfoCopyWithImpl(this._value, this._then);

  final QiitaInfo _value;
  // ignore: unused_field
  final $Res Function(QiitaInfo) _then;

  @override
  $Res call({
    Object title = freezed,
    Object url = freezed,
    Object qiitaUser = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed ? _value.title : title as String,
      url: url == freezed ? _value.url : url as String,
      qiitaUser:
          qiitaUser == freezed ? _value.qiitaUser : qiitaUser as QiitaUser,
    ));
  }

  @override
  $QiitaUserCopyWith<$Res> get qiitaUser {
    if (_value.qiitaUser == null) {
      return null;
    }
    return $QiitaUserCopyWith<$Res>(_value.qiitaUser, (value) {
      return _then(_value.copyWith(qiitaUser: value));
    });
  }
}

/// @nodoc
abstract class _$QiitaInfoCopyWith<$Res> implements $QiitaInfoCopyWith<$Res> {
  factory _$QiitaInfoCopyWith(
          _QiitaInfo value, $Res Function(_QiitaInfo) then) =
      __$QiitaInfoCopyWithImpl<$Res>;
  @override
  $Res call(
      {String title, String url, @JsonKey(name: 'user') QiitaUser qiitaUser});

  @override
  $QiitaUserCopyWith<$Res> get qiitaUser;
}

/// @nodoc
class __$QiitaInfoCopyWithImpl<$Res> extends _$QiitaInfoCopyWithImpl<$Res>
    implements _$QiitaInfoCopyWith<$Res> {
  __$QiitaInfoCopyWithImpl(_QiitaInfo _value, $Res Function(_QiitaInfo) _then)
      : super(_value, (v) => _then(v as _QiitaInfo));

  @override
  _QiitaInfo get _value => super._value as _QiitaInfo;

  @override
  $Res call({
    Object title = freezed,
    Object url = freezed,
    Object qiitaUser = freezed,
  }) {
    return _then(_QiitaInfo(
      title: title == freezed ? _value.title : title as String,
      url: url == freezed ? _value.url : url as String,
      qiitaUser:
          qiitaUser == freezed ? _value.qiitaUser : qiitaUser as QiitaUser,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_QiitaInfo implements _QiitaInfo {
  _$_QiitaInfo({this.title, this.url, @JsonKey(name: 'user') this.qiitaUser});

  factory _$_QiitaInfo.fromJson(Map<String, dynamic> json) =>
      _$_$_QiitaInfoFromJson(json);

  @override
  final String title;
  @override
  final String url;
  @override
  @JsonKey(name: 'user')
  final QiitaUser qiitaUser;
  @override
  String toString() {
    return 'QiitaInfo(title: $title, url: $url, qiitaUser: $qiitaUser)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _QiitaInfo &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.url, url) ||
                const DeepCollectionEquality().equals(other.url, url)) &&
            (identical(other.qiitaUser, qiitaUser) ||
                const DeepCollectionEquality()
                    .equals(other.qiitaUser, qiitaUser)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(url) ^
      const DeepCollectionEquality().hash(qiitaUser);

  @JsonKey(ignore: true)
  @override
  _$QiitaInfoCopyWith<_QiitaInfo> get copyWith =>
      __$QiitaInfoCopyWithImpl<_QiitaInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_QiitaInfoToJson(this);
  }
}

abstract class _QiitaInfo implements QiitaInfo {
  factory _QiitaInfo(
      {String title,
      String url,
      @JsonKey(name: 'user') QiitaUser qiitaUser}) = _$_QiitaInfo;

  factory _QiitaInfo.fromJson(Map<String, dynamic> json) =
      _$_QiitaInfo.fromJson;

  @override
  String get title;
  @override
  String get url;
  @override
  @JsonKey(name: 'user')
  QiitaUser get qiitaUser;
  @override
  @JsonKey(ignore: true)
  _$QiitaInfoCopyWith<_QiitaInfo> get copyWith;
}
