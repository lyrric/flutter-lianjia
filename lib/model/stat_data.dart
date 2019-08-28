import 'package:json_annotation/json_annotation.dart';

part 'generator/stat_data.g.dart';

@JsonSerializable()
class StatData{

  //待售房源数量（总）
  int sellingAmount = 0;
  //售出房源数量（总）
  int soldAmount = 0;

  //待售中的房源平均价格（总）
  double sellingAvgPricePer = 0;
  //已售中的房源平均价格（总）
  double soldAvgPricePer = 0;
  //待售-上月均价（月）
  double sellingLastMonthPricePer = 0;
  //已售-上月均价（月）
  double soldLastMonthPricePer = 0;



  //已售-平均每周增加数量（周）
  int soldAvgWeekIncrease = 0;
  //代售-平均每周增加数量（周）
  int sellingAvgWeekIncrease = 0;
  //已售-平均每月增加数量（月）
  int soldAvgMonthIncrease = 0;
  //代售-平均每月增加数量（月）
  int sellingAvgMonthIncrease = 0;
  //待售-上月更新数量（月）
  int sellingLastMonthIncrease = 0;
  //已售-上月更新数量（月）
  int soldLastMonthIncrease = 0;

  StatData();

  factory StatData.fromJson(Map<String, dynamic> json)=>_$StatDataFromJson(json);
  Map<String, dynamic> toJson()=>_$StatDataToJson(this);

}