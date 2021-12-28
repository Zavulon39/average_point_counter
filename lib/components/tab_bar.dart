import 'package:flutter/material.dart';

class AppTabBar extends BottomNavigationBar {
  AppTabBar(BuildContext context, int currentIndex, String routeName, {Key? key}):
      super(
        key: key,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.filter_1), label: 'Расчёт по ср.арифм.'),
          BottomNavigationBarItem(
              icon: Icon(Icons.filter_2),
              label: 'Расчёт по средневзвеш. баллу'),
        ],
        onTap: (int id) {
          Navigator.pushNamedAndRemoveUntil(
              context, routeName, (route) => false);
        },
        selectedItemColor: const Color.fromRGBO(213, 39, 40, 1),
        currentIndex: currentIndex,
      );
}
