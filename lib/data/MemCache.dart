import 'dart:async';
import 'dart:collection';
import 'Cache.dart';

class MemCache<T> extends Cache<T> {
  final map = HashMap<String, T>();

  @override
  Future<T> get(String index) {
    return Future.value(map[index]);
  }

  @override
  put(String index, object) {
    map[index] = object;
  }

  @override
  bool contains(String index) {
    return map[index] != null;
  }
}