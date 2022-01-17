import 'package:doctor_app/model/feature/sales_model.dart';
import 'package:doctor_app/ui/reusable/global_widget.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class BarCharts10Page extends StatefulWidget {
  @override
  _BarCharts10PageState createState() => _BarCharts10PageState();
}

class _BarCharts10PageState extends State<BarCharts10Page> {
  // initialize global widget
  final _globalWidget = GlobalWidget();

  final List<Sales> _smartphoneData = [
    Sales("2014", 50),
    Sales("2015", 120),
    Sales("2016", 140),
    Sales("2017", 170),
    Sales("2018", 80),
    Sales("2019", 110),
    Sales("2020", 260),
  ];

  final List<Sales> _refrigeratorData = [
    Sales("2014", 30),
    Sales("2015", 150),
    Sales("2016", 180),
    Sales("2017", 270),
    Sales("2018", 180),
    Sales("2019", 90),
    Sales("2020", 370),
  ];

  final List<Sales> _tvData = [
    Sales("2014", 80),
    Sales("2015", 170),
    Sales("2016", 160),
    Sales("2017", 220),
    Sales("2018", 120),
    Sales("2019", 150),
    Sales("2020", 310),
  ];

  late var _series;

  @override
  void initState() {
    _series = [
      charts.Series(
          id: "SmartPhone",
          domainFn: (Sales sales, _) => sales.year,
          measureFn: (Sales sales, _) => sales.sale,
          labelAccessorFn: (Sales sales, _) => sales.sale.toString(),
          data: _smartphoneData
      ),
      charts.Series(
          id: "Refrigerator",
          domainFn: (Sales sales, _) => sales.year,
          measureFn: (Sales sales, _) => sales.sale,
          labelAccessorFn: (Sales sales, _) => sales.sale.toString(),
          data: _refrigeratorData
      ),
      charts.Series(
          id: "TV",
          domainFn: (Sales sales, _) => sales.year,
          measureFn: (Sales sales, _) => sales.sale,
          labelAccessorFn: (Sales sales, _) => sales.sale.toString(),
          data: _tvData
      )
    ];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: _globalWidget.globalAppBar(),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(24, 24, 24, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _globalWidget.createDetailWidget(
                  title: 'Bar Charts 10 (Multi Data with Legend and Value)',
                  desc: 'This is the example of multi data chart with legend and value'
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                child: SizedBox(
                  height: 600,
                  child: charts.BarChart(
                    _series,
                    vertical: false,
                    barGroupingType: charts.BarGroupingType.grouped,
                    behaviors: [charts.SeriesLegend()],
                    barRendererDecorator: charts.BarLabelDecorator<String>(
                        labelPosition: charts.BarLabelPosition.auto
                    ), // write text inside bar, must add labelAccessorFn at charts.Series
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}