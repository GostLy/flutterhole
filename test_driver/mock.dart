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
import 'package:flutterhole/bloc/pihole/bloc.dart';
import 'package:mockito/mockito.dart';

class MockPiholeBloc extends Mock implements PiholeBloc {}

class MockSummaryBloc extends Mock implements SummaryBloc {}

class MockVersionsBloc extends Mock implements VersionsBloc {}

class MockQueriesOverTimeBloc extends Mock implements QueriesOverTimeBloc {}

class MockQueryTypesBloc extends Mock implements QueryTypesBloc {}

class MockForwardDestinationsBloc extends Mock
    implements ForwardDestinationsBloc {}

class MockTopItemsBloc extends Mock implements TopItemsBloc {}

class MockTopSourcesBloc extends Mock implements TopSourcesBloc {}

class MockQueryBloc extends Mock implements QueryBloc {}

class MockStatusBloc extends Mock implements StatusBloc {}

class MockWhitelistBloc extends Mock implements WhitelistBloc {}

class MockBlacklistBloc extends Mock implements BlacklistBloc {}
