import 'package:charts_common/common.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:lianjia/model/selling_house.dart';
import 'package:lianjia/model/sold_house.dart';

///月统计
class MonthStatView extends StatelessWidget {

  ///挂牌中房源月
  List<SellingMonthStat> sellingMonthStat;

  ///已售房源月
  List<SoldMonthStat> soldMonthStat;

  ///纵坐标字段名
  String field;

  var monthStat;

  ///横坐标
  List<TickSpec<DateTime>> ticks;

  MonthStatView(this.sellingMonthStat, this.soldMonthStat, this.field){
    ticks = new List();
    int i = 0;
    if(sellingMonthStat.length != 0){
      while(i < sellingMonthStat.length){
        ticks.add(TickSpec(sellingMonthStat[i].statDate));
        i+=2;
      }
    }else if(soldMonthStat.length != 0){
      while(i < soldMonthStat.length){
        ticks.add(TickSpec(soldMonthStat[i].statDate));
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
    monthStat =
    [
      new charts.Series<SellingMonthStat, DateTime>(
        id:  'sellingMonthStat_' + field,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (SellingMonthStat row, _) => row.statDate,
        measureFn: (SellingMonthStat row, _) => row.toJson()[field],
        data: sellingMonthStat,
      ),
      new charts.Series<SoldMonthStat, DateTime>(
        id: 'soldMonthStat_' + field,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (SoldMonthStat row, _) => row.statDate,
        measureFn: (SoldMonthStat row, _) => row.toJson()[field],
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
}