part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {}

class LodingButtonClicked extends AuthenticationEvent {
  final Authentication authentication;
  LodingButtonClicked(this.authentication);
}

class RegisterButtonClicked extends AuthenticationEvent {
  final Authentication authentication;
  RegisterButtonClicked(this.authentication);
}
