import 'package:flutter/material.dart';
import 'package:sqlite_order_app/screens/order/homepage_screen.dart';

Future<void> main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Order App',
      home: HomePage(),
    );
  }
}
