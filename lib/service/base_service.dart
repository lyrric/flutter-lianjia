
import 'package:dio/dio.dart';
import 'package:lianjia/model/http_result.dart';

abstract class BaseService{
  var dio = Dio();

  BaseService(){
    dio.options.baseUrl = 'http://47.97.215.50:8090';
  }

  bool checkSuccess(Map<String, dynamic> map){
    HttpResult httpResult = HttpResult.fromJson(map);
    if(!httpResult.success){
      print('出错了:'+httpResult.errMsg);
      return false;
    }
    return true;
  }
}