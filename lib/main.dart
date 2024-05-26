import 'package:flutter/material.dart';
import 'package:prista_app/Activity/Splashscreen.dart';
import 'package:prista_app/Activity/DataPenyakitPage.dart';
import 'package:prista_app/Activity/DeteksiPenyakitPage.dart';
import 'package:prista_app/Activity/ProfilePage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prista Apps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    DeteksiPenyakitPage(),
    DataPenyakitPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prista Apps'),
        backgroundColor: Color.fromRGBO(74, 209, 17, 0.582),
        actions: [],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_rounded),
            label: 'Deteksi Penyakit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Data Penyakit',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
