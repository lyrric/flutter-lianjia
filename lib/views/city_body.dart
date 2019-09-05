import 'package:flutter/material.dart';
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

  List<SimpleKeyValue> _sellingAreasStat = new List();

  List<SimpleKeyValue> _soldAreasStat = new List();

  init() {
    _houseStatService.getAreasStat(SysConstant.DATA_TYPE_SELLING).then((data)=>
        super.setState((){
          _sellingAreasStat = data;
        }));
    _houseStatService.getAreasStat(SysConstant.DATA_TYPE_SOLD).then((data)=>
        super.setState((){
          _soldAreasStat = data;
        }));
  }

  CityBodyStat(){
    init();
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
          child: new charts.PieChart(initChartData(_sellingAreasStat, 'selling', true),
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
            child: new charts.PieChart(initChartData(_soldAreasStat, 'sold', false),
                animate: true,
                defaultRenderer: new charts.ArcRendererConfig(
                    arcWidth: 60,
                    arcRendererDecorators: [new charts.ArcLabelDecorator()])),
        ),
      ],
    );
  }

  initChartData(var data, String id, bool isBlue){
    return [
      new charts.Series<SimpleKeyValue, String>(
        id: id,
        colorFn: isBlue?getBlueColor:getGreenColor,
        domainFn: (SimpleKeyValue row, _) => row.key,
        measureFn: (SimpleKeyValue row, _) => row.value,
        data: data,
        labelAccessorFn: (SimpleKeyValue row, _) => '${row.key}: ${row.value}',
      )
    ];
  }

   charts.Color getBlueColor(var data,var index){
     double t =255/18;
     t = t*index;
     int rgb = 255 - t.toInt();
     print('rgb='+rgb.toString());
     return charts.Color(r:0, g:0, b:255, a:rgb);
  }

  charts.Color getGreenColor(var data,int index){
    double t =255/18;
    t = t*index;
    int rgb = 255 - t.toInt();
    print('rgb='+rgb.toString());
    return charts.Color(r:0, g:255, b:0, a:rgb);
  }
}
