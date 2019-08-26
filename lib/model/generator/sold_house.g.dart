// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../sold_house.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SoldWeekStat _$SoldWeekStatFromJson(Map<String, dynamic> json) {
  return SoldWeekStat()
    ..amount = json['amount'] as int
    ..avgPricePer = (json['avgPricePer'] as num)?.toDouble()
    ..increasedAmount = json['increasedAmount'] as int
    ..statDate = json['statDate'] == null
        ? null
        : DateTime.parse(json['statDate'] as String);
}

Map<String, dynamic> _$SoldWeekStatToJson(SoldWeekStat instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'avgPricePer': instance.avgPricePer,
      'increasedAmount': instance.increasedAmount,
      'statDate': instance.statDate?.toIso8601String()
    };

SoldMonthStat _$SoldMonthStatFromJson(Map<String, dynamic> json) {
  return SoldMonthStat()
    ..amount = json['amount'] as int
    ..avgPricePer = (json['avgPricePer'] as num)?.toDouble()
    ..increasedAmount = json['increasedAmount'] as int
    ..statDate = json['statDate'] == null
        ? null
        : DateTime.parse(json['statDate'] as String);
}

Map<String, dynamic> _$SoldMonthStatToJson(SoldMonthStat instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'avgPricePer': instance.avgPricePer,
      'increasedAmount': instance.increasedAmount,
      'statDate': instance.statDate?.toIso8601String()
    };
