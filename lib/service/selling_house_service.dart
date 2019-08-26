
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lianjia/model/selling_house.dart';

import 'base_service.dart';

class SellingHouseService extends BaseService{

  ///周统计
  Future<List<SellingWeekStat>> getSellingWeekStat()async{
    Response response = await dio.get('/remote/sellingWeekStat');
    Map<String, dynamic> httpResultMap = response.data;
    if(checkSuccess(httpResultMap)){
      List<SellingWeekStat> data = new List();
      var listMap = httpResultMap['data'];
      for(var map in listMap){
        SellingWeekStat sellingWeekStat = SellingWeekStat.fromJson(map);
        data.add(sellingWeekStat);
      }
      return data;
    }
    return new List();
  }
  ///月统计
  Future<List<SellingMonthStat>> getSellingMonthStat()async{
    Response response = await dio.get('/remote/sellingMonthStat');
    Map<String, dynamic> httpResultMap = response.data;
    if(checkSuccess(httpResultMap)){
      List<SellingMonthStat> data = new List();
      var listMap = httpResultMap['data'];
      for(var map in listMap){
        SellingMonthStat sellingMonthStat = SellingMonthStat.fromJson(map);
        data.add(sellingMonthStat);
      }
      return data;
    }
    return new List();
  }

}