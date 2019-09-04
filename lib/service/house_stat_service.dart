import 'package:dio/dio.dart';
import 'package:lianjia/model/simple_key_value.dart';
import '../data/system_data.dart';
import 'package:lianjia/model/house_stat.dart';

import 'base_service.dart';


class HouseStatService extends BaseService{
  ///统计
  Future<List<HouseStat>> getHouseStat(int dataType, int statType)async{
    Response response = await dio.get('/remote/getHouseStatData',
        queryParameters: {
          'area': SystemData.county,
          'dataType': dataType,
          'statType':statType
          });
    Map<String, dynamic> httpResultMap = response.data;
    if(checkSuccess(httpResultMap)){
      List<HouseStat> data = new List();
      var listMap = httpResultMap['data'];
      for(var map in listMap){
        HouseStat houseStat = HouseStat.fromJson(map);
        data.add(houseStat);
      }
      return data;
    }
    return new List();
  }

  Future<List<SimpleKeyValue>> getAreasStat(int dataType)async{
    Response response = await dio.get('/remote/getAreasStat',
        queryParameters: {
          'dataType': dataType,
        });
    Map<String, dynamic> httpResultMap = response.data;
    if(checkSuccess(httpResultMap)){
      List<SimpleKeyValue> data = new List();
      var listMap = httpResultMap['data'];
      for(var map in listMap){
        SimpleKeyValue simpleKeyValue = SimpleKeyValue.fromJson(map);
        data.add(simpleKeyValue);
      }
      return data;
    }
    return new List();
  }
}