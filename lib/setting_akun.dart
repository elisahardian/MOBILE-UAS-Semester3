import 'package:flutter/material.dart';

class AccountSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pengaturan Akun"),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.photo),
            title: Text("Ubah Foto Profil"),
            onTap: () {
              // Arahkan ke halaman untuk mengubah nama akun
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Ubah Nama"),
            onTap: () {
              // Arahkan ke halaman untuk mengubah nama akun
            },
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text("Ubah Email"),
            onTap: () {
              // Arahkan ke halaman untuk mengubah email
            },
          ),
          ListTile(
            leading: Icon(Icons.password),
            title: Text("Ubah Password"),
            onTap: () {
              // Arahkan ke halaman untuk mengubah email
            },
          ),
        ],
      ),
    );
  }
}
