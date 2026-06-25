// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthenticateRequest _$AuthenticateRequestFromJson(Map<String, dynamic> json) =>
    _AuthenticateRequest(
      username: json['Username'] as String,
      password: json['Pw'] as String,
    );

Map<String, dynamic> _$AuthenticateRequestToJson(
  _AuthenticateRequest instance,
) => <String, dynamic>{'Username': instance.username, 'Pw': instance.password};

_AuthenticateResponse _$AuthenticateResponseFromJson(
  Map<String, dynamic> json,
) => _AuthenticateResponse(
  accessToken: json['AccessToken'] as String,
  serverId: json['ServerId'] as String,
  user: AuthUser.fromJson(json['User'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AuthenticateResponseToJson(
  _AuthenticateResponse instance,
) => <String, dynamic>{
  'AccessToken': instance.accessToken,
  'ServerId': instance.serverId,
  'User': instance.user,
};

_AuthUser _$AuthUserFromJson(Map<String, dynamic> json) => _AuthUser(
  id: json['Id'] as String,
  name: json['Name'] as String,
  serverId: json['ServerId'] as String?,
  hasPassword: json['HasPassword'] as bool? ?? false,
);

Map<String, dynamic> _$AuthUserToJson(_AuthUser instance) => <String, dynamic>{
  'Id': instance.id,
  'Name': instance.name,
  'ServerId': instance.serverId,
  'HasPassword': instance.hasPassword,
};
