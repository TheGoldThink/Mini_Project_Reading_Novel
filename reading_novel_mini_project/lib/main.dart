// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reading_novel_mini_project/screens/homepage.dart';
import 'package:reading_novel_mini_project/service/database/mongodb.dart';
import 'package:reading_novel_mini_project/service/providers/profileProvider.dart';
import 'package:reading_novel_mini_project/service/providers/provider.dart';
import 'package:provider/provider.dart';

import 'models/favor.dart';

Future<void> main() async {
  WidgetsFlutterBinding();
  await mongoDatabase.connect();
  await Hive.initFlutter();
  Hive.registerAdapter(FavoriteAdapter());
  await Hive.openBox<Favorite>('favorite');
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => NovelProvider()),
          ChangeNotifierProvider(create: (context) => UserProviders())
        ],
        child: const MaterialApp(
          title: 'Mini Project',
          home: HomeScreen(),
        ));
  }
}
