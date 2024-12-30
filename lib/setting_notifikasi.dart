import 'package:flutter/material.dart';

class NotificationSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pengaturan Notifikasi"),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: Text("Aktifkan Notifikasi"),
            subtitle: Text("Izinkan aplikasi mengirimkan notifikasi"),
            value: true, // Set true atau false sesuai status pengaturan
            onChanged: (bool value) {
              // Lakukan sesuatu untuk mengubah pengaturan notifikasi
            },
          ),
        ],
      ),
    );
  }
}
