import 'package:flutter/material.dart';
import 'package:lianjia/model/house_stat.dart';
import 'package:lianjia/service/week_stat_service.dart';
import 'package:lianjia/service/month_stat_service.dart';
import 'package:lianjia/views/month_stat_chart.dart';
import 'package:lianjia/views/week_stat_chart.dart';
import '../model/stat_data.dart';
import '../service/common_service.dart';
import '../data/system_data.dart';

///区县body
class CountyBody extends StatefulWidget{

  @override
  State createState() {
    return CountyBodyStat();
  }
}

class CountyBodyStat extends State<CountyBody>{

  WeekStatService _weekStatService = WeekStatService();

  MonthStatService _monthStatService = MonthStatService();

  CommonService _commonService = CommonService();

  List<HouseStat> _soldMonthLineChartData = new List();
  List<HouseStat> _sellingMonthLineChartData = new List();
  List<HouseStat> _soldWeekLineChartData = new List();
  List<HouseStat> _sellingWeekLineChartData = new List();

  StatData _statData = new StatData();

  init() {
    _weekStatService.getSellingStat().then((data)=>
        super.setState((){
          _sellingWeekLineChartData = data;
        }));
    _weekStatService.getSoldStat().then((data)=>
        super.setState((){
          _soldWeekLineChartData = data;
        }));
    _commonService.getStatData().then((data)=>
        super.setState((){
          _statData = data;
        }));
    _monthStatService.getSellingStat().then((data)=>
        super.setState((){
          _sellingMonthLineChartData = data;
        }));
    _monthStatService.getSoldStat().then((data)=>
        super.setState((){
          _soldMonthLineChartData = data;
        }));
  }

  CountyBodyStat(){
    init();
  }

  @override
  Widget build(BuildContext context) {
    if(SystemData.reload){
      init();
      SystemData.reload = false;
    }
    return SystemData.isWeek?CountyWeekWidget(_sellingWeekLineChartData, _soldWeekLineChartData, _statData)
        :CountyMonthWidget(_sellingMonthLineChartData, _soldMonthLineChartData, _statData);
  }
}

///区县周统计
class CountyWeekWidget extends StatelessWidget {


  List<HouseStat> _sellingLineChartData = new List();

  List<HouseStat> _soldLineChartData = new List();

  //统计数据
  StatData _statData = new StatData();


  CountyWeekWidget(this._sellingLineChartData, this._soldLineChartData,
      this._statData);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        houseAmountRow(),
        housePriceRow(),
        houseIncreaseRow(),
      ],
    );
  }

  //房源数量走势
  Column houseAmountRow() {
    return new Column(
        children: <Widget>[
          new Container(
            padding: const EdgeInsets.only(top: 20),
            child: new Text('房源数量走势', style: TextStyle(color: Colors.indigo)),
          ),
          new WeekLineChart(_sellingLineChartData, _soldLineChartData, 'amount'),
          //房源数量变化
          descWidget('待售房源：', '套      已售房源：', '套',_statData.sellingAmount, _statData.soldAmount),
          new Container(
            padding: const EdgeInsets.only(top: 20),
            child: new Divider(height: 5, color: Colors.amber,),
          ),
        ]
    );
  }

  //房源单位价格走势
  Column housePriceRow() {
    return new Column(
      children: <Widget>[
        new Container(
          padding: const EdgeInsets.only(top: 40),
          child: new Text(
              '平均单位价格走势(元/m²)', style: TextStyle(color: Colors.indigo)),
        ),
        new WeekLineChart(_sellingLineChartData, _soldLineChartData, 'avgPricePer'),
        descWidget('待售均价：', '元/m²     已售均价：', '元/m²',_statData.sellingLastMonthPricePer, _statData.soldLastMonthPricePer),
        descWidget('待售均价：', '元/m²     已售均价：', '元/m²',_statData.sellingAvgPricePer, _statData.soldAvgPricePer),
        new Container(
          padding: const EdgeInsets.only(top: 20),
          child: new Divider(height: 5, color: Colors.amber,),
        ),
      ],
    );
  }

  //房源新增数量走势
  Column houseIncreaseRow() {
    return new Column(
      children: <Widget>[
        new Container(
          padding: const EdgeInsets.only(top: 40),
          child: new Text('房源新增数量走势', style: TextStyle(color: Colors.indigo)),
        ),
        new WeekLineChart( _sellingLineChartData, _soldLineChartData, 'increasedAmount'),
        //房源新增数据变化
        descWidget('上月新增待售：', '套     已售：', '套', _statData.sellingLastMonthIncrease,_statData.soldLastMonthIncrease),
        descWidget('每周平均新增待售：', '套     已售：', '套', _statData.sellingAvgWeekIncrease, _statData.soldAvgWeekIncrease),
        new Container(
          padding: const EdgeInsets.only(top: 20),
          child: new Divider(height: 5, color: Colors.amber,),
        ),
      ],
    );
  }


}

Widget descWidget(String text1, String text2, String text3, var val1, var val2){
  return new Container(
    padding: const EdgeInsets.only(top: 10),
    child: new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text(text1),
        new Text(val1.toString(),
          style: TextStyle(color: Colors.deepOrange),),
        new Text(text2),
        new Text(val2.toString(),
            style: TextStyle(color: Colors.deepOrange)),
        new Text(text3)
      ],
    ),
  );
}

///区县月统计
class CountyMonthWidget extends StatelessWidget{

  List<HouseStat> _sellingLineChartData = new List();

  List<HouseStat> _soldLineChartData = new List();

  //统计数据
  StatData _statData = new StatData();

  CountyMonthWidget(this._sellingLineChartData, this._soldLineChartData,
      this._statData);

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        houseAmountRow(),
        housePriceRow(),
        houseIncreaseRow(),
      ],
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
          new MonthLineChart(_sellingLineChartData, _soldLineChartData, 'amount'), //房源数量变化
          descWidget('待售房源：', '套     已售房源：', '套', _statData.sellingAmount,_statData.soldAmount),
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
        new MonthLineChart(_sellingLineChartData, _soldLineChartData, 'avgPricePer'),//房源单位平均价格变化
        descWidget('上月待售均价：：', '元/m²     上月已售均价：', '元/m²',_statData.sellingLastMonthPricePer, _statData.soldLastMonthPricePer),
        descWidget('待售均价：：', '元/m²     已售均价：', '元/m²',_statData.sellingAvgPricePer, _statData.soldAvgPricePer),
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
        new MonthLineChart(_sellingLineChartData, _soldLineChartData, 'increasedAmount'), //房源新增数据变化
        descWidget('上月新增待售：', '套     已售：', '套', _statData.sellingLastMonthIncrease,_statData.soldLastMonthIncrease),
        descWidget('每月平均新增待售：', '套     已售：', '套', _statData.sellingAvgMonthIncrease,_statData.soldAvgMonthIncrease),
        new Container(
          padding: const EdgeInsets.only(top: 20),
          child:  new Divider(height: 5, color: Colors.amber,),
        ),
      ],
    );
  }
}
