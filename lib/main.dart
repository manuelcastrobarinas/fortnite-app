import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fortnite_app/app/app.dart';
import 'package:fortnite_app/app/di/injection.dart';

/// Punto de entrada: carga `.env`, registra dependencias y arranca la app.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  setupDependencies();
  runApp(const FortniteApp());
}
