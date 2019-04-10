abstract class Cache<T> {
  Future<T> get(String id);
  put(String id, T object);
  bool contains(String id);
}