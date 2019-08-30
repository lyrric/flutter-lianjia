
import 'package:dio/dio.dart';
import 'package:lianjia/model/house_stat.dart';

import 'base_service.dart';

class WeekStatService extends BaseService{

  ///周统计
  Future<List<HouseStat>> getSellingStat(String county)async{
    Response response = await dio.get('/remote/sellingWeekStat', queryParameters: {'county': county});
    Map<String, dynamic> httpResultMap = response.data;
    if(checkSuccess(httpResultMap)){
      List<HouseStat> data = new List();
      var listMap = httpResultMap['data'];
      for(var map in listMap){
        HouseStat sellingWeekStat = HouseStat.fromJson(map);
        data.add(sellingWeekStat);
      }
      return data;
    }
    return new List();
  }

  ///周统计
  Future<List<HouseStat>> getSoldStat(String county)async{
    Response response = await dio.get('/remote/soldWeekStat', queryParameters: {'county': county});
    Map<String, dynamic> httpResultMap = response.data;
    if(checkSuccess(httpResultMap)){
      List<HouseStat> data = new List();
      var listMap = httpResultMap['data'];
      for(var map in listMap){
        HouseStat soldWeekStat = HouseStat.fromJson(map);
        data.add(soldWeekStat);
      }
      return data;
    }
    return new List();
  }

}