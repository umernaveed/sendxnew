import 'package:sendx/data/models/user/user.dart';
import 'package:sendx/domain/datasource/local_data_source.dart';
import 'package:sendx/domain/repositories/local_repository.dart';

class LocalRepositoryImp implements LocalRepository {
  final LocalDataSource _localDataSource;

  LocalRepositoryImp({required LocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<bool> saveUser(User user) async {
    return _localDataSource.saveUser(user);
  }

  @override
  Future<User> getUser() {
    return _localDataSource.getUser();
  }

  @override
  Future<String> getAccessToken() {
    return _localDataSource.getAccessToken();
  }

  @override
  Future<bool> deleteUser() {
    return _localDataSource.deleteUser();
  }

  @override
  Future<String> getLoginToken() {
    return _localDataSource.getLoginToken();
  }

  @override
  Future<bool> isLoggedIn() {
    return _localDataSource.isLoggedIn();
  }

  @override
  Future<void> loggedIN({bool isLoggedIn = true}) {
    return _localDataSource.loggedIN(isLoggedIn: isLoggedIn);
  }

  @override
  User getInstantUser() {
    return _localDataSource.getInstantUser();
  }
}
