import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

  static const _keyName = 'name';
  static const _keyPets = 'pets';
  static const _keyBirthday = 'birthday';

  static Future setName(String username) async =>
      await _storage.write(key: _keyName, value: username);

  static Future<String?> getName() async =>
      await _storage.read(key: _keyName);

  static Future setPets(List<String> pets) async {
    final value = json.encode(pets);

    await _storage.write(key: _keyPets, value: value);
  }

  static Future<List<String>?> getPets() async {
    final value = await _storage.read(key: _keyPets);

    return value == null ? null : List<String>.from(json.decode(value));
  }

  static Future setBirthday(DateTime dateOfBirth) async {
    final birthday = dateOfBirth.toIso8601String();

    await _storage.write(key: _keyBirthday, value: birthday);
  }

  static Future<DateTime?> getBirthday() async {
    final birthday = await _storage.read(key: _keyBirthday);

    return birthday == null ? null : DateTime.tryParse(birthday);
  }
}
