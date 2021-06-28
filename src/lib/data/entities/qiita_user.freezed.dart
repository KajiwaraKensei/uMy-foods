// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'qiita_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
QiitaUser _$QiitaUserFromJson(Map<String, dynamic> json) {
  return _QiitaUser.fromJson(json);
}

/// @nodoc
class _$QiitaUserTearOff {
  const _$QiitaUserTearOff();

// ignore: unused_element
  _QiitaUser call(
      {@JsonKey(name: 'profile_image_url') String profileImageUrl}) {
    return _QiitaUser(
      profileImageUrl: profileImageUrl,
    );
  }

// ignore: unused_element
  QiitaUser fromJson(Map<String, Object> json) {
    return QiitaUser.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $QiitaUser = _$QiitaUserTearOff();

/// @nodoc
mixin _$QiitaUser {
  @JsonKey(name: 'profile_image_url')
  String get profileImageUrl;

  Map<String, dynamic> toJson();
  @JsonKey(ignore: true)
  $QiitaUserCopyWith<QiitaUser> get copyWith;
}

/// @nodoc
abstract class $QiitaUserCopyWith<$Res> {
  factory $QiitaUserCopyWith(QiitaUser value, $Res Function(QiitaUser) then) =
      _$QiitaUserCopyWithImpl<$Res>;
  $Res call({@JsonKey(name: 'profile_image_url') String profileImageUrl});
}

/// @nodoc
class _$QiitaUserCopyWithImpl<$Res> implements $QiitaUserCopyWith<$Res> {
  _$QiitaUserCopyWithImpl(this._value, this._then);

  final QiitaUser _value;
  // ignore: unused_field
  final $Res Function(QiitaUser) _then;

  @override
  $Res call({
    Object profileImageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      profileImageUrl: profileImageUrl == freezed
          ? _value.profileImageUrl
          : profileImageUrl as String,
    ));
  }
}

/// @nodoc
abstract class _$QiitaUserCopyWith<$Res> implements $QiitaUserCopyWith<$Res> {
  factory _$QiitaUserCopyWith(
          _QiitaUser value, $Res Function(_QiitaUser) then) =
      __$QiitaUserCopyWithImpl<$Res>;
  @override
  $Res call({@JsonKey(name: 'profile_image_url') String profileImageUrl});
}

/// @nodoc
class __$QiitaUserCopyWithImpl<$Res> extends _$QiitaUserCopyWithImpl<$Res>
    implements _$QiitaUserCopyWith<$Res> {
  __$QiitaUserCopyWithImpl(_QiitaUser _value, $Res Function(_QiitaUser) _then)
      : super(_value, (v) => _then(v as _QiitaUser));

  @override
  _QiitaUser get _value => super._value as _QiitaUser;

  @override
  $Res call({
    Object profileImageUrl = freezed,
  }) {
    return _then(_QiitaUser(
      profileImageUrl: profileImageUrl == freezed
          ? _value.profileImageUrl
          : profileImageUrl as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_QiitaUser implements _QiitaUser {
  _$_QiitaUser({@JsonKey(name: 'profile_image_url') this.profileImageUrl});

  factory _$_QiitaUser.fromJson(Map<String, dynamic> json) =>
      _$_$_QiitaUserFromJson(json);

  @override
  @JsonKey(name: 'profile_image_url')
  final String profileImageUrl;

  @override
  String toString() {
    return 'QiitaUser(profileImageUrl: $profileImageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _QiitaUser &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                const DeepCollectionEquality()
                    .equals(other.profileImageUrl, profileImageUrl)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(profileImageUrl);

  @JsonKey(ignore: true)
  @override
  _$QiitaUserCopyWith<_QiitaUser> get copyWith =>
      __$QiitaUserCopyWithImpl<_QiitaUser>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_QiitaUserToJson(this);
  }
}

abstract class _QiitaUser implements QiitaUser {
  factory _QiitaUser(
          {@JsonKey(name: 'profile_image_url') String profileImageUrl}) =
      _$_QiitaUser;

  factory _QiitaUser.fromJson(Map<String, dynamic> json) =
      _$_QiitaUser.fromJson;

  @override
  @JsonKey(name: 'profile_image_url')
  String get profileImageUrl;
  @override
  @JsonKey(ignore: true)
  _$QiitaUserCopyWith<_QiitaUser> get copyWith;
}
