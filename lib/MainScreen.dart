

import 'package:example/cart_screen/CartScreen.dart';
import 'package:example/category_screen/category_bloc/category_bloc.dart';
import 'package:example/category_screen/CategoryScreen.dart';
import 'package:example/login_screen/injections.dart';
import 'package:example/NavBarItem.dart';
import 'package:example/user_screen/UserScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _widgetOptions = <Widget>[
    CategoryScreen(),
    UserScreen(),
    CartScreen(),
  ];



  @override
  Widget build(BuildContext context) {
    
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt<CategoryBloc>()..add(LoadCategories()),
        ),
      ],
      child: CupertinoTabScaffold(
        backgroundColor: Colors.black,
        tabBar: CupertinoTabBar(
          border: Border(top: BorderSide.none),
          activeColor: CupertinoColors.black,
          inactiveColor: CupertinoColors.inactiveGray,
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
                activeIcon: NavBarIcon(active: true, title: 'Прачечная', iconName: 'lib/Consts/assets/icon.svg'),
                icon: NavBarIcon(active: false, title: 'Прачечная', iconName: 'lib/Consts/assets/icon.svg'),
                ),
            BottomNavigationBarItem(
              activeIcon: NavBarIcon(active: true, title: 'Профиль', iconName: 'lib/Consts/assets/avatar.svg'),
              icon: NavBarIcon(active: false, title: 'Профиль', iconName: 'lib/Consts/assets/avatar.svg'),
                ),
            BottomNavigationBarItem(
                activeIcon: NavBarIcon(active: true, title: 'Корзина', iconName: 'lib/Consts/assets/cart.svg'),
                icon: NavBarIcon(active: false, title: 'Корзина', iconName: 'lib/Consts/assets/cart.svg'),
                ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
        tabBuilder: (context, index) {
          return Scaffold(
            body: SafeArea(
              child: CupertinoTabView(
                builder: (context) {
                  return _widgetOptions.elementAt(_selectedIndex);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
