part of 'profile_bloc.dart';

@immutable
sealed class ProfileEvent {}

class UserCommentsScreenStarted extends ProfileEvent {}

class UserPaymentsScreenStarted extends ProfileEvent {}
