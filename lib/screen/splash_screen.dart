import 'package:flutter/material.dart';
import 'package:tahura_mobile/screen/home_screen.dart';
import 'package:tahura_mobile/screen/login_screen.dart';
import 'package:tahura_mobile/screen/signup_screen.dart';
import 'package:tahura_mobile/screen/tike_screnn.dart';
import 'dart:async';
import 'katalog_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();

    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                child: Image.asset(
                  'img/logo.png',
                ),
                alignment: Alignment.center,
              ),
            ),
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Image.asset(
                'img/Wildlife.png',
              ),
            ),
          ),
        ],
      ),
      ),
    );

  }
void main() {
  runApp(
    MaterialApp(
      home: SplashScreen(),
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      debugShowCheckedModeBanner: false,
    ),
  );
}
}