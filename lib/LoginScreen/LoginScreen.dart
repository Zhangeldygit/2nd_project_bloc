import 'package:example/LoginScreen/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(

      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is LoadingAuthState) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state is UnAuthState) {
            return Column(
              children: [
                Container(
                  child: Align(alignment: Alignment.center, child: Text("Войти"),),
                ),
                SizedBox(
                  height: 24,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  color: Color(0xffFFFFFF),
                  child: Column(
                    children: [
                      CupertinoTextField(
                        controller: nameController,
                        placeholder: 'Логин',
                        decoration: BoxDecoration(borderRadius: BorderRadius.zero),
                        padding: EdgeInsets.only(left: 4, top: 16, bottom: 16),
                      ),
                      Divider(
                        height: 2,
                        thickness: 1,
                      ),
                      CupertinoTextField(
                        obscureText: true,
                        controller: passwordController,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.zero),
                        placeholder: 'Пароль',
                        padding: EdgeInsets.only(left: 4, top: 16, bottom: 16),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                  width: 375,
                  child: CupertinoButton(
                    color: Colors.blue,
                    onPressed: () {
                      print(state);
                      if (nameController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty) {
                        context.read<AuthBloc>().add(
                              LoginEvent(
                                  nameController.text, passwordController.text),
                            );
                      }
                    },
                    child: Text(
                      'Войти',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            );
          } else if (state is AuthFailure) {
            return Text(state.errorMessage);
          } else {
            print(state);
            return Offstage();
          }
        },
      ),
    );
  }
}
