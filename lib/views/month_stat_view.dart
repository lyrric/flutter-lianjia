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



  MonthStatView(this.sellingMonthStat, this.soldMonthStat, this.field);

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