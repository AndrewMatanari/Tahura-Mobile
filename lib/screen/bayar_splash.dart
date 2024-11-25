import 'package:flutter/material.dart';
import 'package:tahura_mobile/screen/tike_screnn.dart'; // Assuming this is the path to QRCodeScreen

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BayarSplash(),
    );
  }
}

class BayarSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Navigate to QRCodeScreen after a delay
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => QRCodeScreen()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon Check Circle
            Container(
              padding: const EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green, width: 4.0),
              ),
              child: Icon(
                Icons.check,
                size: 60.0,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 30.0),
            // Title Text
            Text(
              'Pembayaran Sukses!',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10.0),
            // Subtitle Text
            Text(
              'Transaksi pembayaran Anda telah berhasil.\n'
              'Anda akan diarahkan ke tampilan QR code Tiket.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

