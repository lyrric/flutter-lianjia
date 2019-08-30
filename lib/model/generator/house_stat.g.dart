// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../house_stat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HouseStat _$HouseStatFromJson(Map<String, dynamic> json) {
  return HouseStat()
    ..amount = json['amount'] as int
    ..area = json['area'] as String
    ..avgPricePer = (json['avgPricePer'] as num)?.toDouble()
    ..increasedAmount = json['increasedAmount'] as int
    ..statDate = json['statDate'] == null
        ? null
        : DateTime.parse(json['statDate'] as String);
}

Map<String, dynamic> _$HouseStatToJson(HouseStat instance) =>
    <String, dynamic>{
      'area': instance.area,
      'amount': instance.amount,
      'avgPricePer': instance.avgPricePer,
      'increasedAmount': instance.increasedAmount,
      'statDate': instance.statDate?.toIso8601String()
    };

