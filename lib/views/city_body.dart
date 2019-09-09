import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lianjia/constant/sys_constant.dart';
import 'package:lianjia/model/simple_key_value.dart';
import 'package:lianjia/service/house_stat_service.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../data/system_data.dart';

///成都市body
class CityBody extends StatefulWidget{

  @override
  State createState() {
    return CityBodyStat();
  }
}

class CityBodyStat extends State<CityBody>{

  HouseStatService _houseStatService = HouseStatService();


  List<SimpleKeyValue> _sellingAreasStat;

  List<SimpleKeyValue> _soldAreasStat;

  List<SimpleKeyValue> _areaAvgPricePerStat = new List();



  init() {
    _houseStatService.getAreasStat(SysConstant.DATA_TYPE_SELLING).then((data)=>
        super.setState((){
          _sellingAreasStat = data;
        }));
    _houseStatService.getAreasStat(SysConstant.DATA_TYPE_SOLD).then((data)=>
        super.setState((){
          _soldAreasStat = data;
        }));
    _houseStatService.getAreasAvgPricePer().then((data)=>
        super.setState((){
          _areaAvgPricePerStat = data;
        }));
  }

  CityBodyStat(){
    init();
  }

  ///平均价格排行榜列表
   Column avgPricePerList(){
     List<Widget> columnList = List();
    if(_areaAvgPricePerStat.length != 0){
      var data = _areaAvgPricePerStat.sublist(10);
      for(int i=0; i<data.length; ){
        List<Widget> rowList = List();
        for(int j=0; j<3 && i<data.length; j++,i++){
          SimpleKeyValue item = data[i];
          Row row = Row(
            children: <Widget>[
              Text(item.key + '：',style: TextStyle(color: Colors.cyan)),
              Text(item.value.toString(), style: TextStyle(color: Colors.deepOrange),),
            ],
          );
          rowList.add(row);
        }
        Row row = new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: rowList,
        );
        columnList.add(row);
      }
    }
     Column column = new Column(
       children: columnList,
     );
    return column;
  }
  @override
  Widget build(BuildContext context) {
    if(SystemData.reload){
      init();
    }
    return Column(
      children: <Widget>[
        new Container(
          padding: const EdgeInsets.only(top: 20),
          child: new Text('各区域待售房源数量', style: TextStyle(color: Colors.indigo)),
        ),
        new Container(
          height: 250,
          child: _sellingAreasStat == null?Text('加载中......'):new charts.PieChart(initChartData(_sellingAreasStat, 'selling', true),
              animate: true,
              defaultRenderer:  new charts.ArcRendererConfig(
                  arcWidth: 60,
                  arcRendererDecorators: [new charts.ArcLabelDecorator()])),
        ),
        new Container(
          padding: const EdgeInsets.only(top: 20),
          child: new Divider(height: 5, color: Colors.amber,),
        ),
        new Container(
          padding: const EdgeInsets.only(top: 20),
          child: new Text('各区域已售房源数量', style: TextStyle(color: Colors.indigo)),
        ),
        new Container(
            height: 250,
            child: _soldAreasStat == null?Text('加载中......'):new charts.PieChart(initChartData(_soldAreasStat, 'sold', false),
                animate: true,
                defaultRenderer: new charts.ArcRendererConfig(
                    arcWidth: 60,
                    arcRendererDecorators: [new charts.ArcLabelDecorator()])),
        ),
        new Container(
          padding: const EdgeInsets.only(top: 20),
          child: new Divider(height: 5, color: Colors.amber,),
        ),
        new Container(
          padding: const EdgeInsets.only(top: 20),
          child: new Text('平均单位房价排行(元/m²)', style: TextStyle(color: Colors.indigo)),
        ),
        new Container(
          height: 250,
          child: new charts.BarChart(
            initAvgPricePerData(),
            animate: true,
            vertical: false,
            barRendererDecorator: new charts.BarLabelDecorator<String>(),
            domainAxis: new charts.OrdinalAxisSpec(),
          ),
        ),
        avgPricePerList(),
    ]
    );
  }

  ///地区熟练分布图
  initChartData(var data, String id, bool isBlue){
    return [
      new charts.Series<SimpleKeyValue, String>(
        id: id,
        colorFn: isBlue?getBlueColor:getGreenColor,
        domainFn: (SimpleKeyValue row, _) => row.key,
        measureFn: (SimpleKeyValue row, _) => row.value,
        data: data,
        labelAccessorFn: (SimpleKeyValue row, _) => '${row.key}: ${row.value.toString()}',
      )
    ];
  }
  ///平均价格排行榜图标前十
  initAvgPricePerData(){
    List<SimpleKeyValue> data = _areaAvgPricePerStat.length >0?_areaAvgPricePerStat.sublist(0, 10):_areaAvgPricePerStat;
    return [
      new charts.Series<SimpleKeyValue, String>(
          id: 'avgPricePer',
          domainFn: (SimpleKeyValue row, _) => row.key,
          measureFn: (SimpleKeyValue row, _) => row.value,
          data:data,
          labelAccessorFn: (SimpleKeyValue row, index) =>'${row.value.toString()}'
      )
    ];
  }
   charts.Color getBlueColor(var data,var index){
     double t =255/18;
     t = t*index;
     int rgb = 255 - t.toInt();
     return charts.Color(r:0, g:0, b:255, a:rgb);
  }

  charts.Color getGreenColor(var data,int index){
    double t =255/18;
    t = t*index;
    int rgb = 255 - t.toInt();
    return charts.Color(r:0, g:255, b:0, a:rgb);
  }
}
