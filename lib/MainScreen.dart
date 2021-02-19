

import 'package:example/CartScreen/CartScreen.dart';
import 'package:example/CategoryScreen/category_bloc/category_bloc.dart';
import 'package:example/CategoryScreen/category_screen.dart';
import 'package:example/LoginScreen/injections.dart';
import 'package:example/UserScreen/UserScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        backgroundColor: Color(0xffE5E5E5),
        tabBar: CupertinoTabBar(
          activeColor: CupertinoColors.black,
          inactiveColor: CupertinoColors.inactiveGray,
          backgroundColor: Colors.white,
          items: [
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset('lib/assets/icon.svg', color: CupertinoColors.black,),
                icon: SvgPicture.asset('lib/assets/icon.svg'),
                label: 'Прачечная'),
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset('lib/assets/avatar.svg', color: CupertinoColors.black,),
                icon: SvgPicture.asset('lib/assets/avatar.svg'),
                label: 'Профиль'),
            BottomNavigationBarItem(
                activeIcon: SvgPicture.asset('lib/assets/cart.svg', color: CupertinoColors.black,),
                icon: SvgPicture.asset('lib/assets/cart.svg'),
                label: 'Корзина'),
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
