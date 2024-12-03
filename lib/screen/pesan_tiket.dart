import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tahura_mobile/screen/bayar_splash.dart';
import 'package:tahura_mobile/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pemesanan Tiket',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: PemesananTiketScreen(),
    );
  }
}

class PemesananTiketScreen extends StatefulWidget {
  @override
  _PemesananTiketScreenState createState() => _PemesananTiketScreenState();
}

class _PemesananTiketScreenState extends State<PemesananTiketScreen> {
  final namaPemesanController = TextEditingController();
  final noKendaraanController = TextEditingController();
  int _jumlahOrang = 1;
  String? _kendaraan;
  String? _pembayaran;
  final nowDate =
      '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';

  Future<void> _pesanTiket() async {
  final namaPemesan = namaPemesanController.text.trim();
  final noKendaraan = noKendaraanController.text.trim();

  if (namaPemesan.isEmpty || noKendaraan.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
          content: Text('Nama Pemesan dan Nomor Kendaraan tidak boleh kosong')),
    );
    return;
  }

  try {
    Uri uri = Uri.https('adminthp.mahasiswarandom.my.id', '/api/add-transaksi');

    final response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer YOUR_API_KEY' // Add authorization if required
      },
      body: jsonEncode({
        'user_id': 1,
        'kode_transaksi': 'THB-${DateTime.now().millisecondsSinceEpoch}',
        'tanggal_transaksi': nowDate,
        'jumlah': _jumlahOrang,
        'total_harga': _jumlahOrang * 17000,
        'no_kendaraan': noKendaraanController.text,
        'jenis_kendaraan': _kendaraan,
        'status': 'Pending',
        'metode_pembayaran': _pembayaran,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BayarSplash()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Server error: ${response.statusCode}')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: $e")),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          },
        ),
        title: Text(
          'Pemesanan Tiket',
          style: GoogleFonts.plusJakartaSans(
              color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            TextField(
              controller: namaPemesanController,
              decoration: InputDecoration(
                  labelText: 'Nama Pemesan',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  )),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: noKendaraanController,
              decoration: InputDecoration(
                labelText: 'Nomor Kendaraan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                nowDate,
                style: GoogleFonts.plusJakartaSans(fontSize: 16.0),
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Jumlah Orang:',
                    style: GoogleFonts.plusJakartaSans(fontSize: 16.0)),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        setState(() {
                          if (_jumlahOrang > 1) _jumlahOrang--;
                        });
                      },
                    ),
                    Text(
                      '$_jumlahOrang',
                      style: GoogleFonts.plusJakartaSans(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      onPressed: () {
                        setState(() {
                          _jumlahOrang++;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Jenis Kendaraan:',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildCheckbox('Mobil', 'Mobil'),
                _buildCheckbox('Sepeda Motor', 'Sepeda Motor'),
                _buildCheckbox('Tanpa Kendaraan', 'Tanpa Kendaraan'),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Metode Pembayaran:',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            Column(
              children: [
                RadioListTile(
                  title: Row(
                    children: [
                      Image.asset('img/shopee pay.png', width: 24.0),
                      SizedBox(width: 8.0),
                      Text('Shopee Pay'),
                    ],
                  ),
                  value: 'Shopee Pay',
                  groupValue: _pembayaran,
                  onChanged: (value) {
                    setState(() {
                      _pembayaran = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: Row(
                    children: [
                      Image.asset('img/gopay.png', width: 24.0),
                      SizedBox(width: 8.0),
                      Text('Gopay'),
                    ],
                  ),
                  value: 'Gopay',
                  groupValue: _pembayaran,
                  onChanged: (value) {
                    setState(() {
                      _pembayaran = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: Row(
                    children: [
                      Image.asset('img/ovo.png', width: 24.0),
                      SizedBox(width: 8.0),
                      Text('OVO'),
                    ],
                  ),
                  value: 'OVO',
                  groupValue: _pembayaran,
                  onChanged: (value) {
                    setState(() {
                      _pembayaran = value.toString();
                    });
                  },
                ),
                RadioListTile(
                  title: Row(
                    children: [
                      Image.asset('img/dana.png', width: 24.0),
                      SizedBox(width: 8.0),
                      Text('DANA'),
                    ],
                  ),
                  value: 'DANA',
                  groupValue: _pembayaran,
                  onChanged: (value) {
                    setState(() {
                      _pembayaran = value.toString();
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Detail Pembayaran:',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            _buildPaymentDetailRow('Harga Tiket (1 pengunjung)', 'Rp 17.000'),
            _buildPaymentDetailRow('Harga Parkir', 'Rp 5.000'),
            _buildPaymentDetailRow('Total Harga', 'Rp 22.000'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _pesanTiket,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(56, 166, 140, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 14.0),
              ),
              child: Text('Bayar',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 16.0, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckbox(String label, String value) {
    return Container(
      width: 300,
      child: CheckboxListTile(
        value: _kendaraan == value,
        onChanged: (selected) {
          setState(() {
            _kendaraan = selected! ? value : null;
          });
        },
        title: Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 15.0)),
        controlAffinity: ListTileControlAffinity.leading,
        dense: false,
      ),
    );
  }

  Widget _buildPaymentDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
