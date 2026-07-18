import '../domain/entities/user_entity.dart';

class UserModel {
  final String uid;
  final String email;
  final String role;

  static const String defaultRole = 'buyer';

  static const List<String> allowedRoles = [
    'buyer',
    'seller',
    'admin',
  ];

  const UserModel({
    required this.uid,
    required this.email,
    required this.role,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    final role = map['role']?.toString() ?? defaultRole;

    return UserModel(
      uid: map['uid']?.toString() ?? '',
      email: map['email']?.toString() ?? '',
      role: allowedRoles.contains(role) ? role : defaultRole,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel.fromMap(json);
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      uid: entity.uid,
      email: entity.email,
      role: entity.role,
    );
  }

  factory UserModel.empty() {
    return const UserModel(
      uid: '',
      email: '',
      role: defaultRole,
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      uid: uid,
      email: email,
      role: role,
    );
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? role,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      role: role ?? this.role,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'role': role,
    };
  }

  Map<String, dynamic> toJson() {
    return toMap();
  }

  @override
  String toString() {
    return 'UserModel(uid: $uid, email: $email, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is UserModel &&
            other.uid == uid &&
            other.email == email &&
            other.role == role;
  }

  @override
  int get hashCode {
    return Object.hash(
      uid,
      email,
      role,
    );
  }
}