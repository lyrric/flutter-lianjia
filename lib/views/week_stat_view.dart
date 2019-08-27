import 'package:charts_common/common.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:lianjia/model/selling_house.dart';
import 'package:lianjia/model/sold_house.dart';

///周统计
class WeekStatView extends StatelessWidget {

  ///挂牌中房源周
  List<SellingWeekStat> sellingWeekStat;

  ///已售房源周
  List<SoldWeekStat> soldWeekStat;

  ///纵坐标字段名
  String field;

  var weekStat;

  ///横坐标
  List<TickSpec<DateTime>> ticks;

  WeekStatView(this.sellingWeekStat, this.soldWeekStat, this.field){
    ticks = new List();
    int i = 0;
    if(sellingWeekStat.length != 0){
      while(i < sellingWeekStat.length){
        ticks.add(TickSpec(sellingWeekStat[i].statDate));
        i+=2;
      }
    }else if(soldWeekStat.length != 0){
      while(i < soldWeekStat.length){
        ticks.add(TickSpec(soldWeekStat[i].statDate));
        i+=2;
      }
    }else{
      DateTime dateTime = DateTime.now();
      while(i < 12){
        ticks.add(TickSpec(dateTime));
        dateTime = dateTime.add(Duration(days: -31));
        i+=2;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    weekStat =
    [
      new charts.Series<SellingWeekStat, DateTime>(
        id:  'sellingWeekStat_' + field,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (SellingWeekStat row, _) => row.statDate,
        measureFn: (SellingWeekStat row, _) => row.toJson()[field],
        data: sellingWeekStat,
      ),
      new charts.Series<SoldWeekStat, DateTime>(
        id: 'soldWeekStat_' + field,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (SoldWeekStat row, _) => row.statDate,
        measureFn: (SoldWeekStat row, _) => row.toJson()[field],
        data: soldWeekStat,
      )
    ];
    return new Container(
      height: 250,
      child: new charts.TimeSeriesChart(weekStat,
          animate: true,
          domainAxis: new charts.DateTimeAxisSpec(
              tickProviderSpec: StaticDateTimeTickProviderSpec(ticks),
              tickFormatterSpec:  new charts.AutoDateTimeTickFormatterSpec(
                day: new charts.TimeFormatterSpec( format: 'MM-dd', transitionFormat: 'MM-dd'),
              )
          ),
          behaviors: [
            new charts.RangeAnnotation([
            ]),
          ],
      ),
    );
  }
}