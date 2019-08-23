// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selling_house.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SellingWeekStat _$SellingWeekStatFromJson(Map<String, dynamic> json) {
  return SellingWeekStat()
    ..amount = json['amount'] as int
    ..avgPricePer = (json['avgPricePer'] as num)?.toDouble()
    ..increasedAmount = json['increasedAmount'] as int
    ..statDate = json['statDate'] == null
        ? null
        : DateTime.parse(json['statDate'] as String);
}

Map<String, dynamic> _$SellingWeekStatToJson(SellingWeekStat instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'avgPricePer': instance.avgPricePer,
      'increasedAmount': instance.increasedAmount,
      'statDate': instance.statDate?.toIso8601String()
    };

SellingMonthStat _$SellingMonthStatFromJson(Map<String, dynamic> json) {
  return SellingMonthStat()
    ..amount = json['amount'] as int
    ..avgPricePer = (json['avgPricePer'] as num)?.toDouble()
    ..increasedAmount = json['increasedAmount'] as int
    ..statDate = json['statDate'] == null
        ? null
        : DateTime.parse(json['statDate'] as String);
}

Map<String, dynamic> _$SellingMonthStatToJson(SellingMonthStat instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'avgPricePer': instance.avgPricePer,
      'increasedAmount': instance.increasedAmount,
      'statDate': instance.statDate?.toIso8601String()
    };
