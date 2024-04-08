import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_app/core/managers/hive_manager.dart';
import 'package:movies_app/injection_container.dart';
import 'package:movies_app/my_app.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await HiveManager.init();
  init();

  runApp(const MyApp());
}
