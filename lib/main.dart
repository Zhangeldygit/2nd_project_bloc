import 'package:example/CartScreen/cart_bloc.dart';
import 'package:example/LoginScreen/LoginScreen.dart';
import 'package:example/LoginScreen/bloc/auth_bloc.dart';
import 'package:example/LoginScreen/injections.dart';
import 'package:example/MainScreen.dart';
import 'package:example/ProductsScreen/Product_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('tokens');
  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox('Cart');


  setUp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (_) => getIt()..add(CheckAuthEvent()),
            lazy: false,
          ),
          BlocProvider<CartBloc>(
            create: (_) => getIt<CartBloc>()..add(InitCart()),
            lazy: false,
          ),

        ],
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (c, s) => MaterialApp(
            debugShowCheckedModeBanner: false,
            home: s is LoginState ? MainScreen() : LoginScreen(),
          ),
        ));
  }
}
