import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:tahura_mobile/screen/home_screen.dart';
import 'package:tahura_mobile/screen/settings_screen.dart';
=======
import 'package:tahura_mobile/screen/pesan_tiket.dart';
>>>>>>> 7541c913bb012065a2f2fbad06e02f815312338a
import 'package:tahura_mobile/screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tahura Mobile',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}


