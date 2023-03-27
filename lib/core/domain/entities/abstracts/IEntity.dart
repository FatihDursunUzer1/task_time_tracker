abstract class IEntity<T> {
  late final String id;
  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson(T entity);
}
