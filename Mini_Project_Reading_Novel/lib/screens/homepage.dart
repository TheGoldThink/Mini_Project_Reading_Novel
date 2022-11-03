// ignore_for_file: file_names

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:Mini_Project_Reading_Novel/screens/ProfileScreens.dart';
import 'package:Mini_Project_Reading_Novel/screens/favorite_screens.dart';
import 'package:Mini_Project_Reading_Novel/screens/widgets/viewModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 1;
  final navigationkey = GlobalKey<CurvedNavigationBarState>();
  final items = <Widget>[
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
        buttonBackgroundColor: Colors.purple,
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
