// ignore_for_file: file_names, depend_on_referenced_packages

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:reading_novel_mini_project/screens/ProfileScreens.dart';
import 'package:reading_novel_mini_project/screens/bookmark_screens.dart';
import 'package:reading_novel_mini_project/screens/favoriteAPI.dart';
import 'package:reading_novel_mini_project/screens/widgets/viewModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 2;
  late List profile, novelss;

  final navigationkey = GlobalKey<CurvedNavigationBarState>();
  final items = <Widget>[
    const Icon(
      Icons.bookmark,
      size: 30,
    ),
    const Icon(
      Icons.favorite,
      size: 30,
    ),
    const Icon(
      Icons.home,
      size: 30,
    ),
    const Icon(
      Icons.person,
      size: 30,
    )
  ];
  final screens = [
    const FavoriteScreens(),
    const FavoriteAPI(),
    const novelViewModel(),
    const ProfileScreens()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      key: navigationkey,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: screens[index],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.white,
        buttonBackgroundColor: Colors.purple.shade300,
        index: index,
        items: items,
        onTap: (index) => setState(() {
          this.index = index;
        }),
        letIndexChange: (index) => true,
        height: 50,
      ),
    );
  }
}
