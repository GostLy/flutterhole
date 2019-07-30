import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:flutterhole/bloc/api/blacklist.dart';
import 'package:flutterhole/bloc/api/forward_destinations.dart';
import 'package:flutterhole/bloc/api/queries_over_time.dart';
import 'package:flutterhole/bloc/api/query.dart';
import 'package:flutterhole/bloc/api/query_types.dart';
import 'package:flutterhole/bloc/api/status.dart';
import 'package:flutterhole/bloc/api/summary.dart';
import 'package:flutterhole/bloc/api/top_items.dart';
import 'package:flutterhole/bloc/api/top_sources.dart';
import 'package:flutterhole/bloc/api/versions.dart';
import 'package:flutterhole/bloc/api/whitelist.dart';
import 'package:flutterhole/service/globals.dart';
import 'package:flutterhole/service/routes.dart';
import 'package:flutterhole/widget/app.dart';
import 'package:persist_theme/data/models/theme_model.dart';

import 'mock.dart';

void main() {
  Globals.router = Router();
  configureRoutes(Globals.router);

  enableFlutterDriverExtension();

  final MockSummaryBloc summaryBloc = MockSummaryBloc();
  final MockVersionsBloc versionsBloc = MockVersionsBloc();
  final MockQueriesOverTimeBloc queriesOverTimeBloc = MockQueriesOverTimeBloc();
  final MockQueryTypesBloc queryTypesBloc = MockQueryTypesBloc();
  final MockForwardDestinationsBloc forwardDestinationsBloc =
      MockForwardDestinationsBloc();
  final MockTopSourcesBloc topSourcesBloc = MockTopSourcesBloc();
  final MockTopItemsBloc topItemsBloc = MockTopItemsBloc();
  final MockQueryBloc queryBloc = MockQueryBloc();
  final MockStatusBloc statusBloc = MockStatusBloc();
  final MockWhitelistBloc whitelistBloc = MockWhitelistBloc();
  final MockBlacklistBloc blacklistBloc = MockBlacklistBloc();

  runApp(App(
    themeModel: ThemeModel(),
    providers: <BlocProvider>[
      BlocProvider<SummaryBloc>(builder: (context) => summaryBloc),
      BlocProvider<VersionsBloc>(builder: (context) => versionsBloc),
      BlocProvider<QueriesOverTimeBloc>(
          builder: (context) => queriesOverTimeBloc),
      BlocProvider<QueryTypesBloc>(builder: (context) => queryTypesBloc),
      BlocProvider<ForwardDestinationsBloc>(
          builder: (context) => forwardDestinationsBloc),
      BlocProvider<TopSourcesBloc>(builder: (context) => topSourcesBloc),
      BlocProvider<TopItemsBloc>(builder: (context) => topItemsBloc),
      BlocProvider<QueryBloc>(builder: (context) => queryBloc),
      BlocProvider<StatusBloc>(builder: (context) => statusBloc),
      BlocProvider<WhitelistBloc>(builder: (context) => whitelistBloc),
      BlocProvider<BlacklistBloc>(builder: (context) => blacklistBloc),
    ],
  ));
}
