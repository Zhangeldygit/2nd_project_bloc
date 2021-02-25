import 'package:example/Consts/color_consts.dart';
import 'package:example/Consts/text_style_consts.dart';
import 'package:example/login_screen/bloc/auth_bloc.dart';
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
    return Scaffold(
      appBar: CupertinoNavigationBar(
        // centerTitle: true,
        middle: Text(
          'Войти',
          style: AllTextStyles.AppBarTextStyle
        ),
        brightness: Brightness.light,
        backgroundColor: AllColors.CardBackgroundColor,
         // elevation: 0,
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is LoadingAuthState) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state is UnAuthState) {
            return Column(
              children: [
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
                        style: AllTextStyles.LogInHintTextStyle,
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
                        style: AllTextStyles.LogInHintTextStyle,
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
                  height: 43,
                  child: CupertinoButton(
                    padding: EdgeInsets.all(1),
                    color: AllColors.ButtonColor,
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
                      style: AllTextStyles.ButtonTextStyle,
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
