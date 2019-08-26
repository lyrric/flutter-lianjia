import 'package:json_annotation/json_annotation.dart';

part 'generator/sold_house.g.dart';

@JsonSerializable()
class SoldWeekStat{

  ///总共售出房屋数量
  int amount;

  ///本月售出房源单位平均价格
  double avgPricePer;

  ///本月新增数据
  int increasedAmount;

  ///统计时间
  DateTime statDate;

  SoldWeekStat();

  factory SoldWeekStat.fromJson(Map<String, dynamic> json)=>_$SoldWeekStatFromJson(json);
  Map<String, dynamic> toJson()=>_$SoldWeekStatToJson(this);

  dynamic getValue(String field){
    return amount;
  }
}

@JsonSerializable()
class SoldMonthStat{

  ///总共售出房屋数量
  int amount;

  ///本月售出房源单位平均价格
  double avgPricePer;

  ///本周新增数据
  int increasedAmount;

  ///统计时间
  DateTime statDate;

  SoldMonthStat();

  factory SoldMonthStat.fromJson(Map<String, dynamic> json)=>_$SoldMonthStatFromJson(json);
  Map<String, dynamic> toJson()=>_$SoldMonthStatToJson(this);
}