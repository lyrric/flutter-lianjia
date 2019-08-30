import 'package:dio/dio.dart';
import 'package:lianjia/model/house_stat.dart';

import 'base_service.dart';


class MonthStatService extends BaseService{


  ///月统计
  Future<List<HouseStat>> getSoldStat(String county)async{
    Response response = await dio.get('/remote/soldMonthStat', queryParameters: {'county': county});
    Map<String, dynamic> httpResultMap = response.data;
    if(checkSuccess(httpResultMap)){
      List<HouseStat> data = new List();
      var listMap = httpResultMap['data'];
      for(var map in listMap){
        HouseStat soldMonthStat = HouseStat.fromJson(map);
        data.add(soldMonthStat);
      }
      return data;
    }
    return new List();
  }
  ///月统计
  Future<List<HouseStat>> getSellingStat(String county)async{
    Response response = await dio.get('/remote/sellingMonthStat', queryParameters: {'county': county});
    Map<String, dynamic> httpResultMap = response.data;
    if(checkSuccess(httpResultMap)){
      List<HouseStat> data = new List();
      var listMap = httpResultMap['data'];
      for(var map in listMap){
        HouseStat sellingMonthStat = HouseStat.fromJson(map);
        data.add(sellingMonthStat);
      }
      return data;
    }
    return new List();
  }
}