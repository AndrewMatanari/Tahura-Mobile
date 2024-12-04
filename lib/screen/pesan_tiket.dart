import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:tahura_mobile/screen/bayar_splash.dart';
import 'package:tahura_mobile/screen/home_screen.dart';
import 'package:tahura_mobile/screen/riwayat_screen.dart';
import 'package:tahura_mobile/screen/tike_screnn.dart';

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
  String _jenisTiket = 'Perorang'; // Default ticket type is Perorang
  final nowDate =
      '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}';
  int _totalHarga = 0;

  // Function to save ticket to history
  Future<void> _simpanRiwayat(String title, String subtitle, String date,
      String time, String price) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> riwayatList = prefs.getStringList('riwayat') ?? [];

    Map<String, String> tiket = {
      'title': title,
      'subtitle': subtitle,
      'date': date,
      'time': time,
      'price': price,
    };

    // Convert map to JSON string
    String tiketJson = json.encode(tiket);
    riwayatList.add(tiketJson);

    // Save list of tickets back to shared preferences
    await prefs.setStringList('riwayat', riwayatList);
  }

  // Method to calculate the total price based on the vehicle type and perorang price
  void _hitungHarga() {
    int hargaKendaraan = 0;
    if (_kendaraan == 'Sepeda Motor') {
      hargaKendaraan = 5000;
    } else if (_kendaraan == 'Mobil') {
      hargaKendaraan = 10000;
    } else if (_kendaraan == 'Bus') {
      hargaKendaraan = 50000;
    }

    // Calculate price based on ticket type
    if (_jenisTiket == 'Perorang') {
      _totalHarga = (_jumlahOrang * 15000) + hargaKendaraan;
    } else if (_jenisTiket == 'Rombongan') {
      // For Rombongan, the minimum 15 people rule applies, and price calculation remains the same
      _totalHarga = (_jumlahOrang * 15000) + hargaKendaraan;
    }
  }

  Future<void> _pesanTiket() async {
    final namaPemesan = namaPemesanController.text.trim();
    final noKendaraan = noKendaraanController.text.trim();

    if (namaPemesan.isEmpty || noKendaraan.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Nama Pemesan dan Nomor Kendaraan tidak boleh kosong')),
      );
      return;
    }

    // Simulate ticket booking process
    String title = namaPemesan;
    String subtitle = _kendaraan ?? 'Motor';
    String date = '14/10/2024'; // Example date
    String time = '02:00pm'; // Example time
    String price = 'Rp $_totalHarga';

    // Save the ticket to history
    await _simpanRiwayat(title, subtitle, date, time, price);

    // After booking, navigate to the RiwayatScreen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => QRCodeScreen()),
    ).then((_) {
      setState(() {
        // any state update if needed after returning from RiwayatScreen
      });
    });

    // Check if the ticket type and vehicle constraints are satisfied
    if (_jenisTiket == 'Rombongan' && _jumlahOrang < 30) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Untuk tiket rombongan, jumlah orang minimal 30')),
      );
      return;
    }

    if (_kendaraan == 'Sepeda Motor' && _jumlahOrang > 2) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Motor hanya bisa untuk 2 orang')),
      );
      return;
    }

    if (_kendaraan == 'Mobil' && _jumlahOrang > 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mobil hanya bisa untuk 6 orang')),
      );
      return;
    }

    if (_kendaraan == 'Bus' && _jumlahOrang < 30) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bus minimal untuk 30 orang')),
      );
      return;
    }

    try {
      Uri uri =
          Uri.https('adminthp.mahasiswarandom.my.id', '/api/add-transaksi');

      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization':
              'Bearer YOUR_API_KEY' // Add authorization if required
        },
        body: jsonEncode({
          'user_id': 1,
          'kode_transaksi': 'THB-${DateTime.now().millisecondsSinceEpoch}',
          'tanggal_transaksi': nowDate,
          'jumlah': _jumlahOrang,
          'total_harga': _totalHarga,
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

  bool enable = true;

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
            // Ticket Type Selection
            Text(
              'Jenis Tiket:',
              style: GoogleFonts.plusJakartaSans(fontSize: 16.0),
            ),
            Row(
              children: [
                Radio(
                  value: 'Perorang',
                  groupValue: _jenisTiket,
                  onChanged: (value) {
                    setState(() {
                      _jenisTiket = value.toString();
                      _jumlahOrang = 1; // Reset people count when ticket type changes
                      enable = true;
                    });
                  },
                ),
                Text('Perorang',
                    style: GoogleFonts.plusJakartaSans(fontSize: 16)),
                SizedBox(width: 20),
                Radio(
                  value: 'Rombongan',
                  groupValue: _jenisTiket,
                  onChanged: (value) {
                    setState(() {
                      _jenisTiket = value.toString();
                      _jumlahOrang = 30;
                      enable = false;
                    });
                  },
                ),
                Text('Rombongan',
                    style: GoogleFonts.plusJakartaSans(fontSize: 16)),
              ],
            ),
            SizedBox(height: 16.0),
            // Nama Pemesan
            TextField(
              controller: namaPemesanController,
              decoration: InputDecoration(
                labelText: 'Nama Pemesan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            // Nomor Kendaraan
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
            // Date
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
            // Jumlah Orang
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
                          _hitungHarga(); // Recalculate the price
                        });
                      },
                    ),
                    Text(
                      '$_jumlahOrang',
                      style: GoogleFonts.plusJakartaSans(fontSize: 16.0),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      onPressed: () {
                        setState(() {
                          if (_jenisTiket == 'Perorang' &&
                              (_kendaraan == 'Sepeda Motor' &&
                                      _jumlahOrang < 2 ||
                                  _kendaraan == 'Mobil' && _jumlahOrang < 6)
                          ) {
                            _jumlahOrang++;
                          } else if(_jenisTiket == 'Rombongan' && _kendaraan == 'Bus' && _jumlahOrang < 30) {
                            _jumlahOrang++;
                          }
                          _hitungHarga(); // Recalculate the price
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),
            // Kendaraan
            Text('Jenis Kendaraan:',
                style: GoogleFonts.plusJakartaSans(fontSize: 16.0)),
            Column(
              children: [
                _buildCheckbox('Sepeda Motor', 'Sepeda Motor', enable),
                _buildCheckbox('Mobil', 'Mobil', enable),
                _buildCheckbox('Bus', 'Bus', !enable),
                _buildCheckbox('Tanpa Kendaraan', 'Tanpa Kendaraan', enable),
              ],
            ),
            SizedBox(height: 16.0),
            // Pembayaran
            Text('Metode Pembayaran:',
                style: GoogleFonts.plusJakartaSans(fontSize: 16.0)),
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
            // Total Price
            Text(
              'Total Harga: Rp $_totalHarga',
              style: GoogleFonts.plusJakartaSans(
                  fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
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

  Widget _buildCheckbox(String label, String value, bool isDisable) {
    return Container(
      width: 300,
      child: CheckboxListTile(
        enabled: isDisable,
        value: _kendaraan == value,
        onChanged: (selected) {
          setState(() {
            _kendaraan = selected! ? value : null;
            _hitungHarga(); // Recalculate price when vehicle changes
          });
        },
        title: Text(label, style: GoogleFonts.plusJakartaSans(fontSize: 15.0)),
        controlAffinity: ListTileControlAffinity.leading,
        dense: false,
      ),
    );
  }
}
