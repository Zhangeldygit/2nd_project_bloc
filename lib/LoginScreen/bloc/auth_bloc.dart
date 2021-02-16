import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:example/LoginScreen/datasource.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Box tokens;
  final LoginDataSource loginDataSource;
  AuthBloc(this.tokens, this.loginDataSource) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is CheckAuthEvent) {
      yield LoadingAuthState();
      try {
        String accessToken = tokens.get('access');
        if (accessToken != null) {
          await loginDataSource.verifyToken();
          yield LoginState();
        } else {
          yield UnAuthState();
        }
      } on DioError catch (e) {
        this.add(CheckAuthEvent());
      }
    } else if (event is LoginEvent) {
      yield LoadingAuthState();
      try {
        final String email = event.email;
        final String password = event.password;
        await loginDataSource.logIn(email: email, password: password);
        yield LoginState();
      } catch (e) {
        yield AuthFailure();
        throw e;
      }
    } else if(event is LogOutEvent) {
      yield UnAuthState();
      await loginDataSource.logOut();
      print(state);
    }
  }
}
