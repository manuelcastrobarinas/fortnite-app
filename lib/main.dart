import 'package:flutter/material.dart';
import 'package:fortnite_app/contants.dart';
import 'package:fortnite_app/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fortnite Flutter App',
      theme: ThemeData(
        colorScheme : ColorScheme.fromSeed(seedColor: kPrimaryColor),
        useMaterial3: false,
        primaryColor: kPrimaryColor,
        fontFamily  : kPrimaryFont,
      ),
      routes: routes,
      initialRoute: 'loading',
    );
  }
}