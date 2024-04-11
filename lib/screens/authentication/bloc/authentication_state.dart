part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationState {}

final class AuthenticationInitial extends AuthenticationState {}

class LoginLoading extends AuthenticationState {}

class LoginError extends AuthenticationState {
  final String error;
  LoginError(this.error);
}

class LodingSuccess extends AuthenticationState {
  final String accessToken;
  LodingSuccess(this.accessToken);
}
//

class RegisterLoading extends AuthenticationState {}

class RegisterError extends AuthenticationState {
  final String error;
  RegisterError(this.error);
}

class RegisterSuccess extends AuthenticationState {}
