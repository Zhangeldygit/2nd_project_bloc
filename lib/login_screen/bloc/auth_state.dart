part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class UnAuthState extends AuthState {}

class LoadingAuthState extends AuthState {}

class LoginState extends AuthState {}

class AuthFailure extends AuthState {
  final String errorMessage;

  AuthFailure({this.errorMessage});

  @override
  String toString() => errorMessage;
}