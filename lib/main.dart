import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lianjia/service/selling_house_service.dart';
import 'package:lianjia/service/sold_house_service.dart';
import 'package:lianjia/service/version_service.dart';
import 'package:lianjia/views/week_stat_view.dart';

import 'model/selling_house.dart';
import 'model/sold_house.dart';

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
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {

  _MyHomePageState(){
    init();
  }

  ///挂牌中房源周
  List<SellingWeekStat> sellingWeekStatData = new List();
  ///已售房源周
  List<SoldWeekStat> soldWeekStatData =  new List();

  List<SellingMonthStat> sellingMonthStatData = new List();
  List<SoldMonthStat> soldMonthStatData = new List();

  var versionService = VersionService();
  var soldHouseService = SoldHouseService();
  var sellingHouseService = SellingHouseService();

  String updateDate = '- -';



  void init(){
    versionService.getUpdateTime().then((data)=>{
      super.setState((){
          updateDate = data;
      })
    });
    sellingHouseService.getSellingWeekStat().then((data)=>{
      super.setState((){
        sellingWeekStatData = data;
      })
    });
//    sellingHouseService.getSellingMonthStat().then((data)=>{
//      super.setState((){
//        sellingMonthStatData = data;
//      })
//    });
//    soldHouseService.getSoldWeekStat().then((data)=>{
//      super.setState((){
//        soldWeekStatData = data;
//      })
//    });
//    soldHouseService.getSoldMonthStat().then((data)=>{
//      super.setState((){
//        soldMonthStatData = data;
//      })
//    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('成都链家可视化：数据更新时间 ' + updateDate),
      ),
      body: new Column(
        children: <Widget>[
          new WeekStatView(sellingWeekStatData, soldWeekStatData, 'amount'), //房源数量变化
          //new WeekStatView(sellingWeekStatData, soldWeekStatData, 'avg_price_per'), //房源单位平均价格变化
          //new WeekStatView(sellingWeekStatData, soldWeekStatData, 'increased_amount'), //房源新增数据变化
        ],
      )
    );
  }


}

