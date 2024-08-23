import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fortnite_app/contants.dart';
import 'package:fortnite_app/routes/routes.dart';

void main() async {
  const envFileName ='.env'; //este es
  await dotenv.load(fileName: envFileName);
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