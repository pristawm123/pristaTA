import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile_image.jpg'), // Replace with your image asset
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(
                  //   'Nama Pengguna:',
                  //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  // ),
                  // SizedBox(width: 10),
                  // Text(
                  //   'Prista',
                  //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  // ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Email:',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'prista@gmail.com',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  // Aksi untuk menampilkan profil
                },
                icon: Icon(Icons.person),
                label: Text('Lihat Profil'),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  // Aksi untuk mengubah nama
                },
                icon: Icon(Icons.edit),
                label: Text('Ubah Nama'),
              ),
              // ElevatedButton.icon(
              //   onPressed: () {
              //     // Aksi untuk mengubah foto profil
              //   },
              //   icon: Icon(Icons.image),
              //   label: Text('Ubah Foto Profil'),
              // ),
              ElevatedButton.icon(
                onPressed: () {
                  // Aksi untuk keluar
                },
                icon: Icon(Icons.exit_to_app),
                label: Text('Keluar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}