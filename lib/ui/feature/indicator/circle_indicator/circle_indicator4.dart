/*
https://pub.dev/packages/percent_indicator
*/
import 'package:doctor_app/ui/reusable/global_widget.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CircleIndicator4Page extends StatefulWidget {
  @override
  _CircleIndicator4PageState createState() => _CircleIndicator4PageState();
}

class _CircleIndicator4PageState extends State<CircleIndicator4Page> {
  // initialize global widget
  final _globalWidget = GlobalWidget();

  @override
  void initState() {
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
            Container(
              child: _globalWidget.createDetailWidget(
                  title: 'Circle Indicator - Gradient Color',
                  desc: 'This is the example of circle indicator with gradient color'
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: CircularPercentIndicator(
                radius: 90.0,
                lineWidth: 10.0,
                percent: 0.8,
                center: Text('80%'),
                backgroundColor: Colors.grey,
                linearGradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  tileMode: TileMode.clamp,
                  stops: [0.0, 1.0],
                  colors: <Color>[
                    Colors.purple,
                    Colors.green,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
