import 'package:flutter/material.dart';

class SystemSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pengaturan Sistem"),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text("Mode Gelap"),
            subtitle: Text("Aktifkan mode gelap untuk aplikasi ini"),
            value: true, // Set true atau false sesuai status pengaturan
            onChanged: (bool value) {}, // Fungsi callback untuk mengubah tema
          ),
          ListTile(
            title: Text("Bahasa"),
            subtitle: Text("Pilih bahasa yang digunakan"),
            onTap: () {
              // Pilih bahasa
            },
          ),
        ],
      ),
    );
  }
}
