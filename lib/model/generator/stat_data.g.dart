// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../stat_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatData _$StatDataFromJson(Map<String, dynamic> json) {
  return StatData()
    ..sellingAmount = json['sellingAmount'] as int
    ..soldAmount = json['soldAmount'] as int
    ..sellingAvgPricePer = (json['sellingAvgPricePer'] as num)?.toDouble()
    ..soldAvgPricePer = (json['soldAvgPricePer'] as num)?.toDouble()
    ..sellingLastMonthPricePer =
        (json['sellingLastMonthPricePer'] as num)?.toDouble()
    ..soldLastMonthPricePer = (json['soldLastMonthPricePer'] as num)?.toDouble()
    ..soldAvgWeekIncrease = json['soldAvgWeekIncrease'] as int
    ..sellingAvgWeekIncrease = json['sellingAvgWeekIncrease'] as int
    ..sellingLastMonthIncrease = json['sellingLastMonthIncrease'] as int
    ..soldLastMonthIncrease = json['soldLastMonthIncrease'] as int
    ..soldAvgMonthIncrease = json['soldAvgMonthIncrease'] as int
    ..sellingAvgMonthIncrease = json['sellingAvgMonthIncrease'] as int;
}

Map<String, dynamic> _$StatDataToJson(StatData instance) => <String, dynamic>{
      'sellingAmount': instance.sellingAmount,
      'soldAmount': instance.soldAmount,
      'sellingAvgPricePer': instance.sellingAvgPricePer,
      'soldAvgPricePer': instance.soldAvgPricePer,
      'sellingLastMonthPricePer': instance.sellingLastMonthPricePer,
      'soldLastMonthPricePer': instance.soldLastMonthPricePer,
      'soldAvgWeekIncrease': instance.soldAvgWeekIncrease,
      'sellingAvgWeekIncrease': instance.sellingAvgWeekIncrease,
      'sellingLastMonthIncrease': instance.sellingLastMonthIncrease,
      'soldLastMonthIncrease': instance.soldLastMonthIncrease,
      'soldAvgMonthIncrease': instance.soldAvgMonthIncrease,
      'sellingAvgMonthIncrease': instance.sellingAvgMonthIncrease
    };
