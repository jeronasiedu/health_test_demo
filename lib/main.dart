import 'package:flutter/material.dart';
import 'package:health/pulmonary.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        appBarTheme: const AppBarTheme(
          elevation: 0,
        ),
        // useMaterial3: true,
      ),
      home: const Pulmonary(),
    );
  }
}
