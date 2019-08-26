import 'package:json_annotation/json_annotation.dart';

part 'generator/http_result.g.dart';

@JsonSerializable()
class HttpResult{
  bool success;
  int successCode;
  String errMsg;
  Object data;

  HttpResult();

  factory HttpResult.fromJson(Map<String, dynamic> json)=>_$HttpResultFromJson(json);
  Map<String, dynamic> toJson()=>_$HttpResultToJson(this);
}