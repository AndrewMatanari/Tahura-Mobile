import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code Tiket',
      home: QRCodeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class QRCodeScreen extends StatefulWidget {
  @override
  _QRCodeScreenState createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  String? transactionId;
  String status = 'berhasil';
  String apiUrl = 'https://adminthp.mahasiswarandom.my.id/api/update-transaksi';
  String dataTransaksiUrl =
      'https://adminthp.mahasiswarandom.my.id/api/data-transaksi?user_id=';
  String userId = '1'; // Ganti dengan user_id yang sesuai

  @override
  void initState() {
    super.initState();
    _fetchLatestTransactionId(); // Ambil data transaksi saat inisialisasi
  }

  Future<void> _fetchLatestTransactionId() async {
    final fullUrl = '$dataTransaksiUrl$userId';

    try {
      final response = await http.get(Uri.parse(fullUrl));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Periksa apakah data adalah daftar atau objek
        if (data is List<dynamic> && data.isNotEmpty) {
          // Jika data adalah List, ambil transaksi terakhir
          final latestTransaction = data.last;
          final kodeTiket = latestTransaction['id']; // Ambil kode tiket
          setState(() {
            transactionId = kodeTiket;
          });
        } else if (data is Map<String, dynamic>) {
          // Jika data adalah Map, langsung ambil nilai
          final kodeTiket = (data['data'].first['id']).toString(); // Ambil kode tiket
          print('INI KODE TIKET: --------- ${kodeTiket} ------------');
          setState(() {
            transactionId = kodeTiket;
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengambil data transaksi.')),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan jaringan! Error:$e')),
      );
    }
  }

  Future<void> _updateStatus(BuildContext context) async {
    final updateUrl = '$apiUrl?id=$transactionId&status=$status';

    try {
      final response = await http.get(Uri.parse(updateUrl));

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Status berhasil diperbarui!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Gagal memperbarui status. Kode: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Terjadi kesalahan jaringan qr!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final qrData = transactionId != null
        ? '$apiUrl?id=$transactionId&status=$status'
        : 'Loading...';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'QR Code Tiket',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (transactionId == null)
              CircularProgressIndicator()
            else
              Column(
                children: [
                  GestureDetector(
                    onTap: () => _updateStatus(context),
                    child: QrImageView(
                      data: qrData,
                      version: QrVersions.auto,
                      size: 200.0,
                      errorCorrectionLevel: QrErrorCorrectLevel.M,
                      gapless: false,
                      foregroundColor: Colors.black,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Kode Tiket: $transactionId',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ElevatedButton(
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Tidak ada halaman sebelumnya!')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(56, 166, 140, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              ),
              child: Text(
                'Kembali',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
