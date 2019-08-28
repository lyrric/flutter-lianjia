
import 'package:dio/dio.dart';
import 'package:lianjia/model/stat_data.dart';

import 'base_service.dart';

class CommonService extends BaseService{

  Future<StatData> getStatData() async{
    Response response = await dio.get("/remote/statData");
    Map<String, dynamic> httpResult = response.data;
    if(checkSuccess(httpResult)){
      return StatData.fromJson(httpResult['data']);
    }
  }
}