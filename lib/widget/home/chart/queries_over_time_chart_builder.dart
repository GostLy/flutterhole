import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterhole/bloc/api/queries_over_time.dart';
import 'package:flutterhole/bloc/base/bloc.dart';
import 'package:flutterhole/model/api/queries_over_time.dart';
import 'package:flutterhole/widget/home/chart/queries_over_time_line_chart.dart';

class QueriesOverTimeChartBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final QueriesOverTimeBloc queriesOverTimeBloc =
        BlocProvider.of<QueriesOverTimeBloc>(context);
    return BlocBuilder(
      bloc: queriesOverTimeBloc,
      builder: (context, state) {
        if (state is BlocStateError<QueriesOverTime>) {
          return ListTile(
            leading: Icon(Icons.warning),
            title: Text('Cannot load queries over time: ${state.e.message}'),
          );
        }

        if (queriesOverTimeBloc.hasCache) {
          final queriesOverTime = queriesOverTimeBloc.cache;

          List<FlSpot> domainSpots = [];
          List<FlSpot> adSpots = [];
          double maxY = 0;

          int index = 0;
          queriesOverTime.clientsOverTime.forEach((String str, int hits) {
            if (hits.toDouble() > maxY) maxY = hits.toDouble();

            final double posX = index.toDouble() *
                (2400 / queriesOverTime.clientsOverTime.length);

            domainSpots.add(FlSpot(posX, hits.toDouble()));
            index++;
          });

          index = 0;
          queriesOverTime.adsOverTime.forEach((String str, int hits) {
            if (hits.toDouble() > maxY) maxY = hits.toDouble();

            adSpots.add(FlSpot(
                index.toDouble() * (2400 / queriesOverTime.adsOverTime.length),
                hits.toDouble()));
            index++;
          });

          return QueriesOverTimeLineChart(
            greenSpots: domainSpots..removeLast(),
            redSpots: adSpots..removeLast(),
            maxY: maxY,
          );
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
