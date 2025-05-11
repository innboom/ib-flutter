import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  // 私有构造函数
  SecureStorage._internal();

  // 单例实例
  static final SecureStorage _instance = SecureStorage._internal();

  // 获取单例实例
  factory SecureStorage() {
    return _instance;
  }

  // 创建 FlutterSecureStorage 实例
  final _secureStorage = const FlutterSecureStorage();

  // 存储数据
  Future<void> set(String key, String value) async {
    await _secureStorage.write(key: key, value: value);
  }

  // 读取数据
  Future<String?> get(String key) async {
    return await _secureStorage.read(key: key);
  }

  // 删除数据
  Future<void> delete(String key) async {
    await _secureStorage.delete(key: key);
  }

  // 删除所有数据
  Future<void> deleteAll() async {
    await _secureStorage.deleteAll();
  }

  // 检查是否存在某个键
  Future<bool> containsKey(String key) async {
    return await _secureStorage.containsKey(key: key);
  }
}
