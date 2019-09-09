import 'package:charts_common/common.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:lianjia/model/house_stat.dart';

///月统计
class MonthLineChart extends StatelessWidget {

  ///挂牌中房源月
  List<HouseStat> sellingMonthStat;

  ///已售房源月
  List<HouseStat> soldMonthStat;

  ///纵坐标字段名
  String field;

  var monthStat;

  ///横坐标
  List<TickSpec<DateTime>> ticks;

  MonthLineChart(this.sellingMonthStat, this.soldMonthStat, this.field){
    iniTicket();
  }

  @override
  Widget build(BuildContext context) {
    monthStat =
    [
      new charts.Series<HouseStat, DateTime>(
        id:  'sellingMonthStat_' + field,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (HouseStat row, _) => row.statDate,
        measureFn: (HouseStat row, _) => row.toJson()[field],
        data: sellingMonthStat,
      ),
      new charts.Series<HouseStat, DateTime>(
        id: 'soldMonthStat_' + field,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (HouseStat row, _) => row.statDate,
        measureFn: (HouseStat row, _) => row.toJson()[field],
        data: soldMonthStat,
      )
    ];
    return new Container(
      height: 250,
      child: new charts.TimeSeriesChart(monthStat,
          animate: true,
          domainAxis: new charts.DateTimeAxisSpec(
              tickProviderSpec: StaticDateTimeTickProviderSpec(ticks),
              tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
                  month: new charts.TimeFormatterSpec( format: 'yyyy-MM', transitionFormat: 'yyyy-MM'),
              )
          ),
          behaviors: [

          ],
      ),
    );
  }
  iniTicket(){
    ticks = List();
    int i = 0;
    if(sellingMonthStat.length != 0){
      while(i < sellingMonthStat.length){
        ticks.add(TickSpec(sellingMonthStat[i].statDate, style:  charts.TextStyleSpec(color: charts.Color.black)));
        i+=2;
      }
    }else if(soldMonthStat.length != 0){
      while(i < soldMonthStat.length){
        ticks.add(TickSpec(soldMonthStat[i].statDate, style:  charts.TextStyleSpec(color: charts.Color.black)));
        i+=2;
      }
    }else{
      DateTime dateTime = DateTime.now();
      while(i < 12){
        ticks.add(TickSpec(dateTime, style:  charts.TextStyleSpec(color: charts.Color.black)));
        dateTime = dateTime.add(Duration(days: -31));
        i+=2;
      }
    }
  }
}