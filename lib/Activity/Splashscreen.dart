// lib/splash_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:prista_app/main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Setelah beberapa detik (misalnya, 3 detik), pindah ke halaman berikutnya
    Timer(Duration(seconds: 2), () {
      // Ganti halaman ke halaman utama aplikasi
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Warna latar belakang splash screen
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Gambar ikon cabai dari assets
            Image.asset(
              'assets/image/cabai.jpg', // Path ke gambar ikon cabai
              width: 100,
              height: 100,
              // Opsi lainnya seperti fit dan colorBlendMode dapat ditambahkan di sini
            ),
            SizedBox(height: 16),
            // Tambahkan teks atau elemen lainnya di sini
            Text(
              'Deteksi Penyakit Cabai',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
