

import 'package:flutter/material.dart';
import 'package:lianjia/data/system_data.dart';
import 'package:lianjia/views/area_select_view.dart';
import 'package:lianjia/views/city_body.dart';

import 'service/common_service.dart';
import 'views/county_body.dart';

void main(){
  // 强制横屏
/*  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);*/
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '成都链家可视化',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      routes:{
        '/select_area':(BuildContext context)=>new AreaSelectView()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {


  CommonService _commonService = new CommonService();

  //数据更新时间
  String updateDate = '- -';

  _MyHomePageState(){
    init();
  }

  void init(){
    _commonService.getUpdateTime().then((data)=>
      super.setState((){
          updateDate = data;
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/bg.png'),
          fit: BoxFit.cover
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar:  AppBar(
            backgroundColor: Colors.blue.withOpacity(0.8),
            title: Text('成都链家可视化'),
            actions: <Widget>[
              new RaisedButton(
                child: new Text(SystemData.county + '∨'),
                color: Colors.blue.withOpacity(0.5),
                textColor: Colors.white,
                highlightElevation: 10.0,//高亮时候的阴影
                disabledElevation: 10.0,//按下的时候的阴影
                onPressed: (){
                  Navigator.of(context).pushNamed('/select_area')
                      .then(
                          (data)=> super.setState((){
                        if(data != null){
                          SystemData.lastCounty = SystemData.county;
                          SystemData.county = data;
                          SystemData.reload = true;
                        }
                      })
                  );
                },
              ),
              new PopupMenuButton(
                itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                  _selectView(Icons.keyboard_arrow_right, SystemData.isWeek?'切换为月统计':'切换为周统计', 'switch_stat_date'),
                ],onSelected: (String action){
                switch(action){
                  case 'switch_stat_date':
                    super.setState(() {
                      SystemData.isWeek = !SystemData.isWeek;
                    });
                    break;
                }
              },
              )
            ],
          ),
          body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Text('数据更新时间 ' + updateDate,
                      style: TextStyle(fontSize: 18, color: Colors.cyan),),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                          padding: const EdgeInsets.only(top: 5),
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              new Image(image: AssetImage('images/blue.png'), width: 80, height: 12,),
                              new Text('待售房源',style: TextStyle(color: Colors.blueAccent )),
                              new Image(image: AssetImage('images/green.png'), width: 80, height: 12,),
                              new Text('已售房源', style: TextStyle(color: Colors.green )),
                            ],
                          ),
                        ),
                      ],
                    ),
                    new CountyBody(),
                    SystemData.county =='成都市'?new CityBody():Text('')
                  ],
                ),
          )
      ),
    );

  }

  // 返回每个隐藏的菜单项
  _selectView(IconData icon, String text, String id) {
    return new PopupMenuItem<String>(
        value: id,
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Icon(icon, color: Colors.blue),
            new Text(text),
          ],
        )
    );
  }
}

