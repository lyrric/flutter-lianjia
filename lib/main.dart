import 'package:flutter/material.dart';
import 'package:lianjia/service/selling_house_service.dart';
import 'package:lianjia/service/sold_house_service.dart';
import 'package:lianjia/service/version_service.dart';
import 'package:lianjia/views/month_stat_view.dart';
import 'package:lianjia/views/week_stat_view.dart';

import 'model/selling_house.dart';
import 'model/sold_house.dart';
import 'model/stat_data.dart';
import 'service/common_service.dart';

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
  bool isWeek = true;

  ///挂牌中房源周
  List<SellingWeekStat> sellingWeekStatData = new List();
  ///已售房源周
  List<SoldWeekStat> soldWeekStatData =  new List();

  List<SellingMonthStat> sellingMonthStatData = new List();
  List<SoldMonthStat> soldMonthStatData = new List();

  ///统计数据
  StatData statData = new StatData();

  var versionService = VersionService();
  var soldHouseService = SoldHouseService();
  var sellingHouseService = SellingHouseService();
  var commonService = CommonService();

  String updateDate = '- -';



  void init(){
    versionService.getUpdateTime().then((data)=>
      super.setState((){
          updateDate = data;
      })
    );
    sellingHouseService.getSellingWeekStat().then((data)=>
      super.setState((){
        sellingWeekStatData = data;
      })
    );
    sellingHouseService.getSellingMonthStat().then((data)=>
      super.setState((){
        sellingMonthStatData = data;
      })
    );
    soldHouseService.getSoldWeekStat().then((data)=>
      super.setState((){
        soldWeekStatData = data;
      })
    );
    soldHouseService.getSoldMonthStat().then((data)=>
      super.setState((){
        soldMonthStatData = data;
      })
    );
    commonService.getStatData().then((data)=>
        super.setState((){
          statData = data;
        })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('成都链家可视化'),
        actions: <Widget>[
          new RaisedButton(
              child: new Text(isWeek?'》切换为月统计':'》切换为周统计'),
              color: Colors.blue,
              textColor: Colors.white,
              highlightElevation: 10.0,//高亮时候的阴影
              disabledElevation: 10.0,//按下的时候的阴影
              onPressed: (){
                setState(() {
                  isWeek = !isWeek;
                });
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
            houseAmountRow(),
            housePriceRow(),
            houseIncreaseRow(),
          ],
        ),
        )
    );
  }
  //房源数量走势
  Column houseAmountRow(){
    return new Column(
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.only(top: 20),
            child: new Text('房源数量走势', style: TextStyle(color: Colors.indigo )),
          ),
          isWeek?new WeekStatView(sellingWeekStatData, soldWeekStatData, 'amount'):new MonthStatView(sellingMonthStatData, soldMonthStatData, 'amount'), //房源数量变化
          new Container(
              padding: const EdgeInsets.only(top: 10),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text('待售房源：'),
                  new Text(statData.sellingAmount.toString(), style: TextStyle(color: Colors.deepOrange ),),
                  new Text('套      已售房源：'),
                  new Text(statData.soldAmount.toString(),  style: TextStyle(color: Colors.deepOrange )),
                  new Text('套')
                ],
              ),

          ),
          new Container(
            padding: const EdgeInsets.only(top: 20),
            child:  new Divider(height: 5, color: Colors.amber,),
          ),
        ]
    );
  }
  //房源单位价格走势
  Column housePriceRow(){
    return new Column(
      children: <Widget>[

        new Container(
          padding: const EdgeInsets.only(top: 40),
          child: new Text('平均单位价格走势(元/m²)', style: TextStyle(color: Colors.indigo )),
        ),
        isWeek?new WeekStatView(sellingWeekStatData, soldWeekStatData, 'avgPricePer'):new MonthStatView(sellingMonthStatData, soldMonthStatData, 'avgPricePer'),//房源单位平均价格变化
        isWeek?Text(''):new Container(
            padding: const EdgeInsets.only(top: 10),
            child:  new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text('上月待售均价：'),
                new Text(statData.sellingLastMonthPricePer.toString(), style: TextStyle(color: Colors.deepOrange ),),
                new Text('元/m²     上月已售均价：'),
                new Text(statData.soldLastMonthPricePer.toString(),  style: TextStyle(color: Colors.deepOrange )),
                new Text('元/m²')
              ],
            ),
        ),
        new Container(
            padding: const EdgeInsets.only(top: 10),
            child:  new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text('待售均价：'),
                new Text(statData.sellingAvgPricePer.toString(), style: TextStyle(color: Colors.deepOrange ),),
                new Text('元/m²     已售均价：'),
                new Text(statData.soldAvgPricePer.toString(),  style: TextStyle(color: Colors.deepOrange )),
                new Text('元/m²')
              ],
            ),
        ),
        new Container(
          padding: const EdgeInsets.only(top: 20),
          child:  new Divider(height: 5, color: Colors.amber,),
        ),
      ],
    );
  }

  //房源新增数量走势
  Column houseIncreaseRow(){
    return  new Column(
      children: <Widget>[
        new Container(
          padding: const EdgeInsets.only(top: 40),
          child: new Text('房源新增数量走势', style: TextStyle(color: Colors.indigo )),
        ),
        isWeek?new WeekStatView(sellingWeekStatData, soldWeekStatData, 'increasedAmount'):new MonthStatView(sellingMonthStatData, soldMonthStatData, 'increasedAmount'), //房源新增数据变化

        isWeek?Text(''): new Container(
            padding: const EdgeInsets.only(top: 10),
            child:  new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text('上月新增待售：'),
                new Text(statData.sellingLastMonthIncrease.toString(), style: TextStyle(color: Colors.deepOrange ),),
                new Text('套     已售：'),
                new Text(statData.soldLastMonthIncrease.toString(),  style: TextStyle(color: Colors.deepOrange )),
                new Text('套')
              ],
            ),
        ),
        isWeek?new Container(
            padding: const EdgeInsets.only(top: 10),
            child:  new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text('每周平均新增待售：'),
                new Text(statData.sellingAvgWeekIncrease.toString(), style: TextStyle(color: Colors.deepOrange ),),
                new Text('套     已售：'),
                new Text(statData.soldAvgWeekIncrease.toString(),  style: TextStyle(color: Colors.deepOrange )),
                new Text('套')
              ],
            ),
        ):new Container(
            padding: const EdgeInsets.only(top: 10),
            child:  new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Text('每月平均新增待售：'),
                new Text(statData.sellingAvgMonthIncrease.toString(), style: TextStyle(color: Colors.deepOrange ),),
                new Text('套     已售：'),
                new Text(statData.soldAvgMonthIncrease.toString(),  style: TextStyle(color: Colors.deepOrange )),
                new Text('套')
              ],
            ),
        ),
        new Container(
          padding: const EdgeInsets.only(top: 20),
          child:  new Divider(height: 5, color: Colors.amber,),
        ),
      ],
    );
  }

}

