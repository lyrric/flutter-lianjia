import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lianjia/data/system_data.dart';

///选择区域
class AreaSelectView extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('请选择地区'),
            leading: new IconButton(icon: Icon(Icons.backup), onPressed: (){
                Navigator.pop(context, null);
            }),
          ),
          body: _BodyWidget(context),
        ),
    );
  }
}

class _BodyWidget extends StatelessWidget{

  BuildContext _context;


  _BodyWidget(this._context);

  VoidCallback _onPressed(String area){
    Navigator.pop(_context, area);
  }

  @override
  Widget build(BuildContext context) {
     return new Column(
       children: <Widget>[
         Container(
           margin: const EdgeInsets.only(top: 20, left: 20),
           child:  new Row(
             children: <Widget>[
               new Text("当前地区:"),
               new Text(SystemData.county),
             ],
           ),
         ),
         new Divider(height: 5, color: Colors.amber,),
         new Container(
           child:new Text('区县列表'),
         ),
         new Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             _customButton('成都市'),
           ],
         ),
         new Divider(height: 5, color: Colors.amber,),
         new Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: <Widget>[
             _customButton('双流'),
             _customButton('天府新区'),
             _customButton('彭州'),
           ],
         ),
         new Divider(height: 5, color: Colors.amber,),
         new Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: <Widget>[
             _customButton('成华'),
             _customButton('新都'),
             _customButton('武侯'),
           ],
         ),
         new Divider(height: 5, color: Colors.amber,),
         new Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: <Widget>[
             _customButton('温江'),
             _customButton('简阳'),
             _customButton('郫都'),
           ],
         ),
         new Divider(height: 5, color: Colors.amber,),
         new Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: <Widget>[
             _customButton('都江堰'),
             _customButton('金牛'),
             _customButton('锦江'),
           ],
         ),
         new Divider(height: 5, color: Colors.amber,),
         new Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: <Widget>[
             _customButton('青白江'),
             _customButton('青羊'),
             _customButton('高新'),
           ],
         ),
         new Row(
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: <Widget>[
             _customButton('龙泉驿'),
           ],
         ),
       ],
     );
  }

  ///自定义按钮
  RaisedButton _customButton(String text){
    return new RaisedButton(
        child: new Text(text),
        color: Colors.blue,
        textColor: Colors.white,
        padding: const EdgeInsets.all(5),
        highlightElevation: 10.0,//高亮时候的阴影
        disabledElevation: 10.0,//按下的时候的阴影
        onPressed: (){
          _onPressed(text);
        }
    );
  }
}

