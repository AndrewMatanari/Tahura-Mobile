import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tahura_mobile/screen/home_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //   builder: (context) => const CartScreen(),
                      //   )
                      // );
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
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Column(
                  children: [
                    Text(
                      'Profil',
                      style: GoogleFonts.plusJakartaSans(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CircleAvatar(
                      backgroundImage: Image.asset('assets/img/user_avatar.png').image,
                      radius: 60,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      // controller: passwordController,
                      initialValue: 'User',
                      decoration: const InputDecoration(
                        labelText: 'Nama lengkap',
                      ),
                      validator: (value) {
                        if(value!.isEmpty) {
                          return 'Silakan isi nama lengkap anda!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      // controller: passwordController,
                      initialValue: 'user@gmail.com',
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        if(value!.isEmpty) {
                          return 'Silakan isi email anda!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      // controller: passwordController,
                      initialValue: '09033421159',
                      decoration: const InputDecoration(
                        labelText: 'Nomor telepon',
                      ),
                      validator: (value) {
                        if(value!.isEmpty) {
                          return 'Silakan isi nomor telepon anda!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      // controller: passwordController,
                      initialValue: '09033421159',
                      decoration: const InputDecoration(
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if(value!.isEmpty) {
                          return 'Silakan isi password anda!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomeScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: const Color(0xFF38A68C),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white)
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}