import 'package:flutterhole/bloc/base/bloc.dart';
import 'package:flutterhole/bloc/base/repository.dart';
import 'package:flutterhole/model/api/blacklist.dart';
import 'package:flutterhole/service/pihole_client.dart';
import 'package:flutterhole/service/pihole_exception.dart';

class Add extends BlocEvent {
  final BlacklistItem item;

  Add(this.item) : super([item]);
}

class Remove extends BlocEvent {
  final BlacklistItem item;

  Remove(this.item) : super([item]);
}

class Edit extends BlocEvent {
  final BlacklistItem original;
  final BlacklistItem update;

  Edit(this.original, this.update) : super([original, update]);
}

class BlacklistBloc extends BaseBloc<Blacklist> {
  final BlacklistRepository blacklistRepository;

  BlacklistBloc(this.blacklistRepository) : super(blacklistRepository);

  @override
  Stream<BlocState> mapEventToState(BlocEvent event,) async* {
    yield BlocStateLoading<Blacklist>();
    if (event is Fetch) yield* fetch();
    if (event is Add) yield* _add(event.item);
    if (event is Remove) yield* _remove(event.item);
    if (event is Edit) yield* _edit(event.original, event.update);
  }

  Stream<BlocState> _add(BlacklistItem item) async* {
    try {
      final blacklist = await blacklistRepository.add(item);
      yield BlocStateSuccess<Blacklist>(blacklist);
    } on PiholeException catch (e) {
      yield BlocStateError<Blacklist>(e);
    }
  }

  Stream<BlocState> _remove(BlacklistItem item) async* {
    try {
      final blacklist = await blacklistRepository.remove(item);
      yield BlocStateSuccess<Blacklist>(blacklist);
    } on PiholeException catch (e) {
      yield BlocStateError<Blacklist>(e);
    }
  }

  Stream<BlocState> _edit(BlacklistItem original, BlacklistItem update) async* {
    try {
      final blacklist = await blacklistRepository.edit(original, update);
      yield BlocStateSuccess<Blacklist>(blacklist);
    } on PiholeException catch (e) {
      yield BlocStateError<Blacklist>(e);
    }
  }
}

class BlacklistRepository extends BaseRepository<Blacklist> {
  BlacklistRepository(PiholeClient client, {Blacklist initialValue})
      : _cache = initialValue ?? Blacklist(),
        super(client);

  Blacklist _cache;

  Blacklist get cache => _cache;

  @override
  Future<Blacklist> get() async {
    _cache = await client.fetchBlacklist();
    return _cache;
  }

  Future<Blacklist> add(BlacklistItem item) async {
    await client.addToBlacklist(item);
    _cache = Blacklist.withItem(_cache, item);
    return _cache;
  }

  Future<Blacklist> remove(BlacklistItem item) async {
    await client.removeFromBlacklist(item);
    _cache = Blacklist.withoutItem(_cache, item);
    return _cache;
  }

  Future<Blacklist> edit(BlacklistItem original, BlacklistItem update) async {
    await client.removeFromBlacklist(original);
    await client.addToBlacklist(update);
    _cache = Blacklist.withoutItem(_cache, original);
    _cache = Blacklist.withItem(_cache, update);
    return _cache;
  }
}
