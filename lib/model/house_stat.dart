import 'package:json_annotation/json_annotation.dart';

part 'package:lianjia/model/generator/house_stat.g.dart';

@JsonSerializable()
class HouseStat{

  ///区县
  String area;

  ///房屋数量
  int amount;

  ///平均单位价格
  double avgPricePer;

  ///新增房源
  int increasedAmount;

  ///统计时间
  DateTime statDate;

  HouseStat();

  factory HouseStat.fromJson(Map<String, dynamic> json)=>_$HouseStatFromJson(json);
  Map<String, dynamic> toJson()=>_$HouseStatToJson(this);

}

