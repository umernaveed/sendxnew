import 'package:firebase_messaging/firebase_messaging.dart';

abstract class FirebaseService {
  Future<String> getFirebaseToken();
}

class FirebaseServiceImpl implements FirebaseService {
  final FirebaseMessaging _firebaseMessaging;
  FirebaseServiceImpl() : _firebaseMessaging = FirebaseMessaging.instance;

  String _token = '';

  @override
  Future<String> getFirebaseToken() async {
    try {
      if (_token.isNotEmpty) return _token;
      final token = await _firebaseMessaging.getToken() ?? ' ';
      _token = token;
      return _token;
    } catch (e) {
      return _token;
    }
  }
}
