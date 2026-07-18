class UserEntity {
  final String uid;
  final String email;
  final String role;

  const UserEntity({
    required this.uid,
    required this.email,
    required this.role,
  });

  UserEntity copyWith({
    String? uid,
    String? email,
    String? role,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      role: role ?? this.role,
    );
  }

  bool get isAdmin => role == 'admin';

  bool get isSeller => role == 'seller';

  bool get isBuyer => role == 'buyer';

  @override
  String toString() {
    return 'UserEntity(uid: $uid, email: $email, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserEntity &&
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