import 'package:flutter/material.dart';
import 'setting_notifikasi.dart';
import 'setting_system.dart';
import 'setting_akun.dart';

class SettingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pengaturan"),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text("Notifikasi"),
            subtitle: Text("Kelola notifikasi yang diterima"),
            onTap: () {
              // Arahkan ke halaman pengaturan notifikasi
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotificationSettingsPage()),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text("Sistem"),
            subtitle: Text("Pengaturan terkait sistem"),
            onTap: () {
              // Arahkan ke halaman pengaturan sistem
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SystemSettingsPage()),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text("Akun"),
            subtitle: Text("Pengaturan akun dan profil"),
            onTap: () {
              // Arahkan ke halaman pengaturan akun
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountSettingsPage()),
              );
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}
