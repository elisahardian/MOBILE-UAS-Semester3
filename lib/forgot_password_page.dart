import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordPage extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  String _message = '';

  Future<void> _resetPassword() async {
    final email = _emailController.text.trim();
    final newPassword = _newPasswordController.text.trim();

    if (email.isEmpty || newPassword.isEmpty) {
      setState(() {
        _message = 'Email dan password tidak boleh kosong.';
      });
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('http://localhost/aplikasi_mobile/reset_password.php'),
        body: {'email': email, 'new_password': newPassword},
      );

      if (response.statusCode == 200) {
        final responseData = response.body;
        setState(() {
          _message = responseData.contains('success')
              ? 'Password berhasil direset.'
              : 'Email tidak ditemukan.';
        });
      } else {
        setState(() {
          _message = 'Gagal mengirim permintaan. Coba lagi.';
        });
      }
    } catch (e) {
      setState(() {
        _message = 'Terjadi kesalahan. Pastikan Anda terhubung ke internet.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Lupa Password'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            width: screenWidth,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Gambar_login2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Foreground content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/logo.png'),
                  ),
                  SizedBox(height: 24),

                  // Title
                  Text(
                    'Lupa Password',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),

                  // Description
                  Text(
                    'Masukkan email Anda dan password baru untuk memulai proses reset.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 32),

                  // Email TextField
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Masukkan Email',
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  // New Password TextField
                  SizedBox(
                    width: screenWidth * 0.8,
                    child: TextField(
                      controller: _newPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password Baru',
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),

                  // Reset Password Button
                  SizedBox(
                    width: screenWidth * 0.6,
                    child: ElevatedButton(
                      onPressed: _resetPassword,
                      child: Text('Reset Password'),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        backgroundColor:
                            const Color.fromARGB(255, 15, 187, 255),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  // Error or Status Message
                  Text(
                    _message,
                    style: TextStyle(
                        color: const Color.fromARGB(255, 251, 255, 5)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
