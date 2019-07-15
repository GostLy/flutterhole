import 'package:flutterhole_again/model/blacklist.dart';
import 'package:flutterhole_again/service/pihole_client.dart';

import 'api_repository.dart';

class BlacklistRepository extends ApiRepository {
  final PiholeClient client;

  Blacklist _cache;

  Blacklist get cache => _cache;

  BlacklistRepository(this.client);

  Future<Blacklist> getBlacklist() async {
    _cache = await client.fetchBlacklist();
    return _cache;
  }

  Future<Blacklist> addToBlacklist(BlacklistItem item) async {
    await client.addToBlacklist(item);
    _cache = Blacklist.cloneWith(_cache, item);
    return _cache;
  }

  Future<Blacklist> removeFromBlacklist(BlacklistItem item) async {
    await client.removeFromBlacklist(item);
    _cache = Blacklist.cloneWithout(_cache, item);
    return _cache;
  }

  Future<Blacklist> editOnBlacklist(
      BlacklistItem original, BlacklistItem update) async {
    await client.removeFromBlacklist(original);
    await client.addToBlacklist(update);
    _cache = Blacklist.cloneWithout(_cache, original);
    _cache = Blacklist.cloneWith(_cache, update);
    return _cache;
  }
}