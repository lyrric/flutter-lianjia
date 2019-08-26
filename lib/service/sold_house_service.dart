import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lianjia/model/sold_house.dart';

import 'base_service.dart';

///已售出房源
class SoldHouseService extends BaseService{
 

  ///周统计
  Future<List<SoldWeekStat>> getSoldWeekStat()async{
    Response response = await dio.get('/remote/soldWeekStat');
    Map<String, dynamic> httpResultMap = response.data;
    if(checkSuccess(httpResultMap)){
      List<SoldWeekStat> data = new List();
      var listMap = httpResultMap['data'];
      for(var map in listMap){
        SoldWeekStat soldWeekStat = SoldWeekStat.fromJson(map);
        data.add(soldWeekStat);
      }
      return data;
    }
    return new List();
  }

  ///月统计
  Future<List<SoldMonthStat>> getSoldMonthStat()async{
    Response response = await dio.get('/remote/soldMonthStat');
    Map<String, dynamic> httpResultMap = response.data;
    if(checkSuccess(httpResultMap)){
      List<SoldMonthStat> data = new List();
      var listMap = httpResultMap['data'];
      for(var map in listMap){
        SoldMonthStat soldMonthStat = SoldMonthStat.fromJson(map);
        data.add(soldMonthStat);
      }
      return data;
    }
    return new List();
  }
}