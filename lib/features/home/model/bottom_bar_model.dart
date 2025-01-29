import 'package:flutter/material.dart';
import 'package:pet_adoption/features/favourite/favourite_page.dart';
import 'package:pet_adoption/features/history/history_screen.dart';
import 'package:pet_adoption/features/home/screen/home_page.dart';

class BottomBarModel {
  final String title;
  final Widget activeIcon;
  final Widget inActiveIcon;
  final Widget page;

  BottomBarModel({
    required this.title,
    required this.activeIcon,
    required this.inActiveIcon,
    required this.page,
  });
}

List<BottomBarModel> getBarList() {
  final List<BottomBarModel> barItems = [
    BottomBarModel(
        title: 'Home',
        activeIcon: const Icon(Icons.home),
        inActiveIcon: const Icon(Icons.home_outlined),
        page: const HomePage()),
    BottomBarModel(
        title: 'History',
        activeIcon: const Icon(Icons.history),
        inActiveIcon: const Icon(Icons.history_outlined),
        page: const HistoryPage()),
    BottomBarModel(
        title: 'Favourite',
        activeIcon: const Icon(Icons.favorite),
        inActiveIcon: const Icon(Icons.favorite_border),
        page: const FavouritePage()),
  ];

  return barItems;
}
