import '../../domain/entities/user_entity.dart';

class AuthState {
  final bool isAuthenticated;
  final bool isLoading;
  final UserEntity? user;
  final String? error;

  const AuthState({
    this.isAuthenticated = false,
    this.isLoading = false,
    this.user,
    this.error,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    UserEntity? user,
    String? error,
    bool clearUser = false,
    bool clearError = false,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      user: clearUser ? null : (user ?? this.user),
      error: clearError ? null : (error ?? this.error),
    );
  }

  AuthState reset() {
    return const AuthState();
  }

  @override
  String toString() {
    return 'AuthState('
        'isAuthenticated: $isAuthenticated, '
        'isLoading: $isLoading, '
        'user: $user, '
        'error: $error'
        ')';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthState &&
        other.isAuthenticated == isAuthenticated &&
        other.isLoading == isLoading &&
        other.user == user &&
        other.error == error;
  }

  @override
  int get hashCode {
    return Object.hash(
      isAuthenticated,
      isLoading,
      user,
      error,
    );
  }
}