import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tahura_mobile/screen/bayar_splash.dart';
import 'package:tahura_mobile/screen/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
  int _jumlahOrang = 1;
  String? _kendaraan;
  String? _pembayaran;

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
          children: [
            // Nama Pemesan
            TextField(
              decoration: InputDecoration(
                labelText: 'Nama Pemesan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                )
              ),
            ),
            SizedBox(height: 16.0),

            // Nomor Kendaraan
            TextField(
              decoration: InputDecoration(
                labelText: 'Nomor Kendaraan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),

            // Tanggal
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Text(
                'Rabu, 12 Agustus 2020',
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

            // Kendaraan
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

            // Metode Pembayaran
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

            // Detail Pembayaran
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

            // Tombol Bayar
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BayarSplash(),
                  ),
                );
              },
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
