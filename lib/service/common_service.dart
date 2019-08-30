
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:lianjia/model/stat_data.dart';


import '../data/system_data.dart';
import 'base_service.dart';

class CommonService extends BaseService{

  ///数据统计
  Future<StatData> getStatData() async{
    Response response = await dio.get("/remote/statData", queryParameters: {'county': SystemData.county});
    Map<String, dynamic> httpResult = response.data;
    if(checkSuccess(httpResult)){
      return StatData.fromJson(httpResult['data']);
    }
  }

  ///获取数据更新时间
  Future<String> getUpdateTime() async {
    Response response = await dio.get('/remote/updateDate');
    Map<String, dynamic> httpResultMap = json.decode(response.data);
    if(checkSuccess(httpResultMap)){
      var date = httpResultMap['data'];
      return date;
    }
    return '--';
  }
}