import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart'; // Untuk mengambil gambar
import 'package:aplikasi_mobile/login.dart';
import 'package:path_provider/path_provider.dart'; // Untuk mendapatkan path direktori
import 'dart:async'; // Untuk timeout exception

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _teleponController = TextEditingController();
  String _message = '';
  File? _imageFile; // Untuk menyimpan gambar yang dipilih

  final ImagePicker _picker = ImagePicker();

  // Fungsi untuk memilih gambar
  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  // Fungsi untuk menyimpan gambar ke folder yang dapat diakses
  Future<void> _saveImage() async {
    if (_imageFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final String imageName =
          '${_namaController.text.split(" ")[0]}.jpg'; // Ambil nama depan
      final String newPath = '${directory.path}/$imageName'; // Path baru

      // Simpan gambar ke path baru
      await _imageFile!.copy(newPath);
      print(
          'Image saved to: $newPath'); // Debugging untuk memastikan penyimpanan
    }
  }

  Future<void> _register() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final nama = _namaController.text;
    final alamat = _alamatController.text;
    final telepon = _teleponController.text;

    await _saveImage(); // Simpan gambar sebelum registrasi

    var uri = Uri.parse(
        //"http://192.168.114.198/flutter/register.php"); // Sesuaikan dengan URL API Anda
        "http://localhost/aplikasi_mobile/register.php");
    var request = http.MultipartRequest('POST', uri);

    // Menambahkan field ke request
    request.fields['email'] = email;
    request.fields['password'] = password;
    request.fields['nama'] = nama;
    request.fields['alamat'] = alamat;
    request.fields['telepon'] = telepon;

    // Menambahkan gambar ke request
    if (_imageFile != null) {
      String imageName = '${_namaController.text.split(" ")[0]}.jpg';
      request.files.add(await http.MultipartFile.fromPath(
          'foto', _imageFile!.path,
          filename: imageName));
    }

    try {
      // Mengatur timeout
      var response = await request
          .send()
          .timeout(Duration(seconds: 10)); // Timeout 10 detik

      if (response.statusCode == 200) {
        var responseData = await http.Response.fromStream(response);
        var jsonData = jsonDecode(responseData.body);

        if (jsonData['value'] == 1) {
          setState(() {
            _message = "Registration successful!";
          });

          // Navigasi ke halaman login setelah registrasi berhasil
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        } else {
          setState(() {
            _message = "Registration failed: ${jsonData['message']}";
          });
        }
      } else {
        setState(() {
          _message =
              "Error during registration. Status Code: ${response.statusCode}";
        });
      }
    } on TimeoutException catch (e) {
      setState(() {
        _message = "Request timed out. Please try again later.";
      });
      print("Request timed out: $e");

      // Anda bisa mengarahkan pengguna ke halaman login jika timeout terjadi
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      setState(() {
        _message = "An error occurred: $e";
      });
      print("Error: $e");

      // Anda bisa mengarahkan pengguna ke halaman login jika ada kesalahan lain
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              TextField(
                controller: _namaController,
                decoration: InputDecoration(
                  labelText: 'Nama',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _alamatController,
                decoration: InputDecoration(
                  labelText: 'Alamat',
                  prefixIcon: Icon(Icons.home),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                ),
                minLines: 3,
                maxLines: 3,
              ),
              SizedBox(height: 16),
              TextField(
                controller: _teleponController,
                decoration: InputDecoration(
                  labelText: 'Telepon',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                ),
              ),
              SizedBox(height: 16),

              // Foto dalam bentuk lingkaran
              CircleAvatar(
                radius: 50,
                backgroundImage:
                    _imageFile != null ? FileImage(_imageFile!) : null,
                child: _imageFile == null
                    ? Icon(Icons.person, size: 50)
                    : null, // Tampilkan icon person jika belum ada foto
              ),
              SizedBox(height: 16),

              // Hanya menampilkan nama file
              if (_imageFile != null)
                Text(
                  'Nama file: ${_namaController.text.split(" ")[0]}.jpg',
                  style: TextStyle(fontSize: 14),
                ),
              SizedBox(height: 16),

              // Tombol Upload Foto
              ElevatedButton(
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text('Upload Foto'),
              ),
              SizedBox(height: 16),

              // Tombol Register
              ElevatedButton(
                onPressed: _register,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: Text('Register'),
              ),
              SizedBox(height: 16),
              Text(
                _message,
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
