import 'package:json_annotation/json_annotation.dart';

part 'selling_house.g.dart';

@JsonSerializable()
class SellingWeekStat{

  ///挂牌中的房屋数量
  int amount;

  ///平均单位价格
  double avgPricePer;

  ///本周新增房源
  int increasedAmount;

  ///创建时间
  DateTime statDate;

  SellingWeekStat();

  factory SellingWeekStat.fromJson(Map<String, dynamic> json)=>_$SellingWeekStatFromJson(json);
  Map<String, dynamic> toJson()=>_$SellingWeekStatToJson(this);

}

@JsonSerializable()
class SellingMonthStat{
  ///挂牌中的房屋数量
  int amount;

  ///平均单位价格（本月上架的）
  double avgPricePer;

  ///本月新增房源
  int increasedAmount;

  ///统计时间
  DateTime statDate;

  SellingMonthStat();

  factory SellingMonthStat.fromJson(Map<String, dynamic> json)=>_$SellingMonthStatFromJson(json);
  Map<String, dynamic> toJson()=>_$SellingMonthStatToJson(this);
}