import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tahura_mobile/screen/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
  }
class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(''),
      ),
      drawer: Drawer(
        //kuduna glassmorphism tapi ntar aja
        backgroundColor: Colors.white.withOpacity(0.9),
        child: Padding(
          padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  ListTile(
                    leading: const Icon(
                      Icons.close_rounded,
                      size: 30,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(height: 50),
                  CircleAvatar(
                    backgroundImage: Image.asset('assets/img/user_avatar.png').image,
                    radius: 60,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'User',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ListTile(
                    leading: const Icon(
                      Icons.history_rounded,
                      size: 30,
                    ),
                    title: Text(
                      'Riwayat Transaksi',
                      style: GoogleFonts.plusJakartaSans(
                          color: Colors.black,
                          fontSize: 17,
                      ),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //   builder: (context) => const SettingScreen(),
                      //   )
                      // );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.shopping_bag_outlined,
                      size: 30,
                    ),
                    title: Text(
                      'Katalog',
                      style: GoogleFonts.plusJakartaSans(
                          color: Colors.black,
                          fontSize: 17,
                      ),
                    ),
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //   builder: (context) => const CartScreen(),
                      //   )
                      // );
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.settings_outlined,
                      size: 30,
                    ),
                    title: Text(
                      'Pengaturan',
                      style: GoogleFonts.plusJakartaSans(
                          color: Colors.black,
                          fontSize: 17,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                        )
                      );
                    },
                  ),
                ],
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout_rounded,
                  size: 30,
                ),
                title: Text(
                  'Keluar',
                  style: GoogleFonts.plusJakartaSans(
                      color: Colors.black,
                      fontSize: 17,
                  ),
                ),
                onTap: () {
                  // Navigator.pushAndRemoveUntil(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => const LoginScreen()),
                  //   (Route<dynamic> route) => false,
                  // );
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(
                        'Selamat Pagi, User',
                        textAlign: TextAlign.start,
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.bold,
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                    Image.asset(
                      'assets/img/home_image.png',
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Tanggal Pembelian',
                          style: GoogleFonts.plusJakartaSans(
                            color: const Color.fromRGBO(56, 166, 140, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          'Sabtu, 23 November 2024',
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () {},
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Color.fromRGBO(56, 166, 140, 1)),
                  ),
                  child: Text(
                    'PESAN TIKET',
                    style: GoogleFonts.plusJakartaSans(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 3,
                    ),
                  ),
                ),
                const SizedBox(height: 20,),
                Text(
                  'Informasi Tiket',
                  style: GoogleFonts.plusJakartaSans(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                SizedBox(
                  height: 110,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 230,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                  BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 5,
                                  spreadRadius: 10,
                                ),
                              ]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 50,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color.fromRGBO(56, 166, 140, 1),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'A0001',
                                        style: GoogleFonts.plusJakartaSans(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Atas nama',
                                        style: GoogleFonts.plusJakartaSans(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 6,),
                                      Text(
                                        'Waktu Berlalu',
                                        style: GoogleFonts.plusJakartaSans(
                                          color: Colors.black,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(width: 10),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color.fromRGBO(56, 166, 140, 1),
                                      ),
                                      child: const Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    )
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      );
                    },
                    itemCount: 3,
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
                  'Rekomendasi Produk',
                  style: GoogleFonts.plusJakartaSans(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 300,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                  BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 5,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Tas Rotan',
                                        style: GoogleFonts.plusJakartaSans(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'Rp. 60.000',
                                        style: GoogleFonts.plusJakartaSans(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Text(
                                          'Selengkapnya',
                                          style: GoogleFonts.plusJakartaSans(
                                            color: const Color.fromRGBO(56, 166, 140, 1),
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Image.asset('assets/img/tas_anjay.png', width: 170),
                                ]
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: 2,
                  ),
                ),
                const SizedBox(height: 10,),
                Text(
                  'Pengumuman',
                  style: GoogleFonts.plusJakartaSans(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            width: 300,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                  BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  blurRadius: 5,
                                  spreadRadius: 10,
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Monyet Gila di Dekat Goa Jepang',
                                    style: GoogleFonts.plusJakartaSans(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Hati-hati di dekat goa jepang ada monyet gila karena sesuatu.....',
                                    style: GoogleFonts.plusJakartaSans(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Text(
                                      'Selengkapnya',
                                      style: GoogleFonts.plusJakartaSans(
                                        color: const Color.fromRGBO(56, 166, 140, 1),
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}