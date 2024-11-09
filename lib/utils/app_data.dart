import 'package:get_secure_storage/get_secure_storage.dart';
import 'package:tezda_app/utils/locator.dart';

class AppData {
  final _box = locator<GetSecureStorage>();

  set token(String value) => _box.write('token', value);

  String get token => _box.read('token') ?? '';

  set email(String phone) => _box.write('email', phone);

  String get email => _box.read('email') ?? '';

  Future<void> clearStorage() async {
    String mail = email;
    await _box.erase();
    email = mail;
  }
}
