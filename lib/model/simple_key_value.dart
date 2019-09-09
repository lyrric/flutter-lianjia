class SimpleKeyValue{
  String key;
  dynamic value;

  SimpleKeyValue();


  SimpleKeyValue.of(String _key, dynamic _value){
    this.key = _key;
    this.value = _value;
  }

  factory SimpleKeyValue.fromJson(Map<String, dynamic> json){
    return SimpleKeyValue()
        ..key = json['key'] as String
        ..value = json['value'] as dynamic;
  }
}