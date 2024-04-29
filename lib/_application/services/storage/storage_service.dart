import "dart:async";
import "dart:convert";

import "package:flutter_secure_storage/flutter_secure_storage.dart";

class StorageService {
  factory StorageService() {
    return I;
  }

  StorageService._() {
    _storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );
  }

  static final StorageService I = StorageService._();

  late final FlutterSecureStorage _storage;

  Future<void> storeData({
    required String key,
    required Map<String, dynamic> data,
  }) async {
    await _storage.write(key: key, value: jsonEncode(data));
  }

  Future<dynamic> readData({required String key}) async {
    final String? data = await _storage.read(key: key);
    if (data != null) {
      return jsonDecode(data);
    } else {
      return null;
    }
  }

  Future deleteData({required String key}) async {
    await _storage.delete(key: key);
  }
}
