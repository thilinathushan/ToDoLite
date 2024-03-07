import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/theme_provider.dart';
import 'pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  //init the hive
  await Hive.initFlutter();

  //open a box
  // ignore: unused_local_variable
  var box = await Hive.openBox('mybox');

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      darkTheme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
