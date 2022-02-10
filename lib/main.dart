import 'package:flutter/material.dart';
import 'package:shopping_cart/src/presentation/screens/home/home_page_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bliss',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePageUI(),
    );
  }
}
