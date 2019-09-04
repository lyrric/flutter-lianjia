class SimpleKeyValue{
  String key;
  dynamic value;

  SimpleKeyValue();

  factory SimpleKeyValue.fromJson(Map<String, dynamic> json){
    return SimpleKeyValue()
        ..key = json['key'] as String
        ..value = json['value'] as dynamic;
  }
}