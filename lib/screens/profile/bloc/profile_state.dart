part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

//comment

class UserCommentsSuccess extends ProfileState {
  final List<UserComments> userComments;
  UserCommentsSuccess(this.userComments);
}

class UserCommentsLoding extends ProfileState {}

class UserCommentsError extends ProfileState {
  final String error;
  UserCommentsError(this.error);
}

//payments

class UserPaymentsSuccess extends ProfileState {
  final List<UserPayments> userPayments;
  UserPaymentsSuccess(this.userPayments);
}

class UserPaymentsLoding extends ProfileState {}

class UserPaymentsError extends ProfileState {
  final String error;
  UserPaymentsError(this.error);
}
