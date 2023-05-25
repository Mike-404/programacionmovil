import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GraphPage extends StatelessWidget {
  final List<DataPoint> data;

  GraphPage({required this.data});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<DataPoint, DateTime>> series = [
      charts.Series(
        id: 'Data',
        data: data,
        domainFn: (DataPoint point, _) => point.date,
        measureFn: (DataPoint point, _) => point.value,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Graph Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: charts.TimeSeriesChart(
          series,
          animate: true,
          dateTimeFactory: const charts.LocalDateTimeFactory(),
        ),
      ),
    );
  }
}

class DataPoint {
  final DateTime date;
  final double value;

  DataPoint({required this.date, required this.value});
}
