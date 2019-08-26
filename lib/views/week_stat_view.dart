import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:lianjia/model/selling_house.dart';
import 'package:lianjia/model/sold_house.dart';

///周统计
class WeekStatView extends StatefulWidget {

  ///挂牌中房源周
  List<SellingWeekStat> sellingWeekStat;

  ///已售房源周
  List<SoldWeekStat> soldWeekStat;

  ///纵坐标字段名
  String field;


  WeekStatView(this.sellingWeekStat, this.soldWeekStat, this.field);

  @override
  State createState()=>_WeekStatViewState(sellingWeekStat, soldWeekStat, field);

}
class _WeekStatViewState extends State<WeekStatView> {

  var amountWeek;

  _WeekStatViewState(List<SellingWeekStat> sellingWeekStat, ///挂牌中房源周
      List<SoldWeekStat> soldWeekStat, ///已售房源周
      String field
      ){
    amountWeek =
    [
      new charts.Series<SellingWeekStat, DateTime>(
        id:  'sellingWeekStat_' + field,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (SellingWeekStat row, _) => row.statDate,
        measureFn: (SellingWeekStat row, _) => row.toJson()[field],
        data: sellingWeekStat,
      ),
//      new charts.Series<SoldWeekStat, DateTime>(
//        id: 'soldWeekStat_' + field,
//        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
//        domainFn: (SoldWeekStat row, _) => row.statDate,
//        measureFn: (SoldWeekStat row, _) => row.toJson()[field],
//        data: soldWeekStat,
//      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new charts.TimeSeriesChart(amountWeek,
          animate: true,
          domainAxis: new charts.DateTimeAxisSpec(
              tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(
                  day: new charts.TimeFormatterSpec(
                      format: 'MM-dd', transitionFormat: 'MM-dd')))),
    );
  }

}