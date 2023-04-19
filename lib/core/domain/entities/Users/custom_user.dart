import 'package:json_annotation/json_annotation.dart';
import 'package:task_time_tracker/core/domain/entities/abstracts/IEntity.dart';

part 'custom_user.g.dart';

@JsonSerializable()
class CustomUser implements IEntity {
  @override
  late String id;

  final String email;
  final String? displayName;
  final String? photoURL;
  final bool emailVerified;

  CustomUser({
    required this.id,
    required this.email,
    this.displayName,
    this.photoURL,
    required this.emailVerified,
  });

  @override
  fromJson(Map<String, dynamic> json) {
    return _$CustomUserFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$CustomUserToJson(this);
  }

  factory CustomUser.fromJson(Map<String, dynamic> json) =>
      _$CustomUserFromJson(json);
}
