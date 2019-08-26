// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../http_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HttpResult _$HttpResultFromJson(Map<String, dynamic> json) {
  return HttpResult()
    ..success = json['success'] as bool
    ..successCode = json['successCode'] as int
    ..errMsg = json['errMsg'] as String
    ..data = json['data'];
}

Map<String, dynamic> _$HttpResultToJson(HttpResult instance) =>
    <String, dynamic>{
      'success': instance.success,
      'successCode': instance.successCode,
      'errMsg': instance.errMsg,
      'data': instance.data
    };
