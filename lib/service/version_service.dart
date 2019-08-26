
import 'dart:convert';

import 'package:dio/dio.dart';

import 'base_service.dart';

class VersionService extends BaseService{

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