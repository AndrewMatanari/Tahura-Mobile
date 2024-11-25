import 'package:flutter/material.dart';
import 'package:tahura_mobile/screen/pesan_tiket.dart';
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
<<<<<<< HEAD
        MaterialPageRoute(builder: (context) => Katalog()),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
=======
        MaterialPageRoute(builder: (context) =>  PemesananTiketScreen()),
      );
    });
>>>>>>> 7541c913bb012065a2f2fbad06e02f815312338a
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
<<<<<<< HEAD
            FadeTransition(
              opacity: _fadeAnimation,
              child: Container(
                child: Image.asset(
                  'assets/img/logo.png',
                ),
                alignment: Alignment.center,
              ),
            ),
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Image.asset(
                'assets/img/Wildlife.png',
              ),
            ),
          ),
        ],
      ),
=======
            Image.asset('img/logo.png', width: 268, height: 115),
            SizedBox(height: 250),
            Image.asset('img/Wildlife.png', width: 375, height: 348),
          ],
        ),
>>>>>>> 7541c913bb012065a2f2fbad06e02f815312338a
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

