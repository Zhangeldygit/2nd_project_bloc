// import 'package:bloc/bloc.dart';
import 'package:example/LoginScreen/LoginScreen.dart';
import 'package:example/LoginScreen/bloc/auth_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({
    Key key,
  }) : super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Color(0xffE5E5E5),
      navigationBar: CupertinoNavigationBar(
        middle: Text('User'),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 80,
          ),
          Container(
            color: Color(0xffFFFFFF),
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Уведомления'),
                CupertinoSwitch(
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
            color: Color(0xffEDF2FF),
            height: 1,
          ),
          Container(
            padding: EdgeInsets.only(top: 8, bottom: 8),
            color: Color(0xffFFFFFF),
            child: Align(
              alignment: Alignment.centerLeft,
              child: CupertinoButton(
                onPressed: () {
                  context.read<AuthBloc>().add(LogOutEvent());
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (BuildContext context) => LoginScreen(),
                    ),
                  );
                },
                child: Text(
                  'Выйти',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
