// import 'package:bloc/bloc.dart';
import 'package:example/Consts/color_consts.dart';
import 'package:example/Consts/text_style_consts.dart';
import 'package:example/login_screen/LoginScreen.dart';
import 'package:example/login_screen/bloc/auth_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatefulWidget {

  UserScreen({Key key,}) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CupertinoNavigationBar(
          backgroundColor: AllColors.CardBackgroundColor,
          middle: Text('admin@inzgiba.me',
              style: AllTextStyles.AppBarTextStyle),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          color: AllColors.CardBackgroundColor,
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Уведомления',
                  style: AllTextStyles.NotificationTextStyle),
              CupertinoSwitch(
                  activeColor: AllColors.ButtonColor,
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                    });
                  })
            ],
          ),
        ),
        Divider(
          color: AllColors.ScreenBackgroundColor,
          height: 1,
        ),
        Container(
          padding: EdgeInsets.only(top: 8, bottom: 8),
          color: AllColors.CardBackgroundColor,
          child: Align(
            alignment: Alignment.centerLeft,
            child: CupertinoButton(
              onPressed: () {
                context.read<AuthBloc>().add(LogOutEvent());
                Navigator.pop(context);
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (BuildContext context) =>
                        LoginScreen(),
                  ),
                );
              },
              child: Text(
                'Выйти',
                style: AllTextStyles.LogOutTextStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
