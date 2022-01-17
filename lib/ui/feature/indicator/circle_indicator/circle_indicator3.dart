/*
https://pub.dev/packages/percent_indicator
*/
import 'package:doctor_app/ui/reusable/global_widget.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CircleIndicator3Page extends StatefulWidget {
  @override
  _CircleIndicator3PageState createState() => _CircleIndicator3PageState();
}

class _CircleIndicator3PageState extends State<CircleIndicator3Page> {
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
                  title: 'Circle Indicator - With Animation',
                  desc: 'This is the example of circle indicator with animation'
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: CircularPercentIndicator(
                radius: 120.0,
                lineWidth: 10.0,
                percent: 0.8,
                center: Text('80%'),
                backgroundColor: Colors.grey,
                progressColor: Colors.red,
                animation: true,
                animationDuration: 1000,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
