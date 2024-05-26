import 'package:flutter/material.dart';
import 'PenyakitCabai.dart';
import 'DetailPenyakit.dart';

class DataPenyakitPage extends StatelessWidget {
  final List<PenyakitCabai> daftarPenyakit = [
    PenyakitCabai(
      nama: 'Penyakit Virus Kuning',
      gambarUrl: '',
      ciriCiri: 'Ciri-ciri penyakit A...',
      penanganan: 'Cara penanganan penyakit A...',
    ),
    PenyakitCabai(
      nama: 'Penyakit B',
      gambarUrl: '',
      ciriCiri: 'Ciri-ciri penyakit B...',
      penanganan: 'Cara penanganan penyakit B...',
    ),
    PenyakitCabai(
      nama: 'Penyakit C',
      gambarUrl: '',
      ciriCiri: 'Ciri-ciri penyakit C...',
      penanganan: 'Cara penanganan penyakit C...',
    ),
  ];

  Future<void> tampilkanDetailPenyakit(BuildContext context, PenyakitCabai penyakit) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPenyakitPage(
          penyakit: penyakit,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: ListView.builder(
        itemCount: daftarPenyakit.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            child: ListTile(
              contentPadding: EdgeInsets.all(10),
              leading: CircleAvatar(
                backgroundImage: AssetImage(daftarPenyakit[index].gambarUrl),
              ),
              title: Text(daftarPenyakit[index].nama),
              subtitle: Text('Klik untuk melihat detail'),
              onTap: () {
                tampilkanDetailPenyakit(context, daftarPenyakit[index]);
              },
            ),
          );
        },
      ),
    );
  }
}