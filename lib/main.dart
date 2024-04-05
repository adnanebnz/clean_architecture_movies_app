import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movies_app/injection_container.dart';
import 'package:movies_app/my_app.dart';

void main() async {
  init();

  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}
