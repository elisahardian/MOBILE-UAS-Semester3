import 'package:flutter/material.dart';
import 'login.dart'; //import halaman login

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Elektornik',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(), //menetapkan login page sebagai halaman utama
      debugShowCheckedModeBanner: false, //// Menonaktifkan banner debug
    );
  }
}
