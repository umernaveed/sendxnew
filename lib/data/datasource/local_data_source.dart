import 'package:hive_flutter/hive_flutter.dart';
import 'package:sendx/data/models/user/user.dart';
import 'package:sendx/domain/datasource/local_data_source.dart';

class LocalDataSourceImp implements LocalDataSource {
  final LocalClient _localClient;

  LocalDataSourceImp({required LocalClient localClient})
      : _localClient = localClient;

  @override
  Future<bool> saveUser(User user) async {
    try {
      await _localClient.appBox.put('user', user);
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String> getAccessToken() async {
    final user = await getUser();
    return user.accessToken;
  }

  @override
  Future<User> getUser() async {
    final r = _localClient.appBox.get('user', defaultValue: User.empty());
    return r;
  }

  @override
  User getInstantUser() {
    final r = _localClient.appBox.get('user', defaultValue: User.empty());
    return r;
  }

  @override
  Future<bool> deleteUser() async {
    try {
      await _localClient.appBox.delete('user');
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<String> getLoginToken() async {
    final user = await getUser();
    return user.loginToken;
  }

  @override
  Future<bool> isLoggedIn() async {
    final r = _localClient.appBox.get('is_logged_in', defaultValue: false);
    return r;
  }

  @override
  Future<void> loggedIN({bool isLoggedIn = true}) async {
    await _localClient.appBox.put('is_logged_in', isLoggedIn);
  }
}

abstract class LocalClient {
  Box get appBox;
  Future<void> init();
  void registerAdapters();
  Future<void> clearBox();
  Future<void> close();
}

class LocalClientImp implements LocalClient {
  final HiveInterface _hive;
  LocalClientImp({required HiveInterface hive}) : _hive = hive {
    init();
  }

  @override
  Box get appBox => _appBox;

  late Box _appBox;

  @override
  Future<void> init() async {
    try {
      await _hive.initFlutter();
      registerAdapters();
      _appBox = await Hive.openBox('BrownBox');
    } catch (_) {}
  }

  @override
  Future<void> clearBox() async {
    await _appBox.clear();
  }

  @override
  Future<void> close() async {
    await _hive.close();
  }

  @override
  void registerAdapters() {
    _hive.registerAdapter(UserAdapter());
  }
}
