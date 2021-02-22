

import 'package:example/CartScreen/CartScreen.dart';
import 'package:example/CategoryScreen/category_bloc/category_bloc.dart';
import 'package:example/CategoryScreen/category_screen.dart';
import 'package:example/LoginScreen/injections.dart';
import 'package:example/NavBarItem.dart';
import 'package:example/UserScreen/UserScreen.dart';
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
                activeIcon: NavBarIcon(active: true, title: 'Прачечная', IconName: 'lib/assets/icon.svg'),
                icon: NavBarIcon(active: false, title: 'Прачечная', IconName: 'lib/assets/icon.svg'),
                ),
            BottomNavigationBarItem(
              activeIcon: NavBarIcon(active: true, title: 'Профиль', IconName: 'lib/assets/avatar.svg'),
              icon: NavBarIcon(active: false, title: 'Профиль', IconName: 'lib/assets/avatar.svg'),
                ),
            BottomNavigationBarItem(
                activeIcon: NavBarIcon(active: true, title: 'Корзина', IconName: 'lib/assets/cart.svg'),
                icon: NavBarIcon(active: false, title: 'Корзина', IconName: 'lib/assets/cart.svg'),
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
