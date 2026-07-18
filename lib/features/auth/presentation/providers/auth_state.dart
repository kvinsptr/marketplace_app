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
  }) {

    return AuthState(
      isAuthenticated:
          isAuthenticated ?? this.isAuthenticated,

      isLoading:
          isLoading ?? this.isLoading,

      user:
          user ?? this.user,

      error:
          error,
    );

  }

}