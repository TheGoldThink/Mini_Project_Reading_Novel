import 'package:flutter/material.dart';
import 'package:Mini_Project_Reading_Novel/screens/homepage.dart';
import 'package:Mini_Project_Reading_Novel/service/database/mongodb.dart';
import 'package:Mini_Project_Reading_Novel/service/providers/provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding();
  await mongoDatabase.connect();
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
        providers: [ChangeNotifierProvider(create: (context) => Novels())],
        child: MaterialApp(
          title: 'Flutter Demo',
          home: const HomeScreen(),
        ));
  }
}
