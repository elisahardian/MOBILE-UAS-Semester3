import 'package:flutter/material.dart';
import 'dart:convert'; // Untuk parsing JSON
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart'; // Impor intl untuk memformat angka
import 'package:aplikasi_mobile/pusat_bantuan.dart';
import 'package:aplikasi_mobile/riwayat_pembelian.dart';
import 'package:aplikasi_mobile/setting_page.dart';
// import 'package:aplikasi_mobile/setting_page.dart';
import 'login.dart'; // Impor halaman login
import 'package:aplikasi_mobile/productdetailpage.dart';
//import 'package:aplikasi_mobile/riwayat_pembelian.dart';
//import 'productdetailpage.dart'; // Impor halaman ProductDetailPage\
import 'keranjang_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List products = [];
  bool isLoading = true; // Menyimpan status loading
  String errorMessage = ''; // Menyimpan pesan error jika ada

  List<Map<String, dynamic>> cart = []; //tambahkan property keranjang
  List<Map<String, dynamic>> history = []; //tambahkan property history
  //tambahkan property detail barang

  //fungsi untuk menmabakna produk kekeranjang
  void addToCart(Map<String, dynamic> product) {
    setState(() {
      cart.add(product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content:
              Text('${product['product']} telah ditambahkan ke keranjang')),
    );
  }

  //fungsi untuk menmabakna produk ke riwayat belanja
  void addToHistory(Map<String, dynamic> product) {
    setState(() {
      history.add(product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(
              '${product['product']} telah ditambahkan ke Riwayat Belanja')),
    );
  }

  // Fungsi untuk mengambil data produk dari API
  Future<void> fetchProducts() async {
    try {
      final response = await http.get(
        Uri.parse(
            //'http://192.168.114.198/flutter/get_products.php'), // Ganti dengan URL API Anda
            'http://localhost/aplikasi_mobile/get_products.php'),
      );

      if (response.statusCode == 200) {
        setState(() {
          products = json.decode(response.body);
          isLoading =
              false; // Set loading ke false setelah data berhasil diambil
        });
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      setState(() {
        isLoading = false; // Set loading ke false jika terjadi error
        errorMessage = e.toString(); // Simpan pesan error
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProducts(); // Panggil fungsi untuk mengambil data saat widget diinisialisasi
  }

  // Fungsi untuk memformat harga
  String formatCurrency(String price) {
    final formatter = NumberFormat.currency(locale: 'id', symbol: 'Rp ');
    return formatter.format(int.parse(price));
  }

  //@override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard Produk'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigasi ke halaman keranjang dengan data keranjang
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => KeranjangPage(
                    cart: cart,
                    addToHistory: addToHistory,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Navigasi ke halaman login
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor:
            Colors.blue, // Mengatur latar belakang drawer menjadi biru
        child: FutureBuilder<SharedPreferences>(
          future: SharedPreferences
              .getInstance(), // Mendapatkan instance SharedPreferences
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator()); // Menunggu data
            } else if (snapshot.hasData) {
              // Ambil data dari SharedPreferences
              SharedPreferences prefs = snapshot.data!;
              String userName = prefs.getString('userName') ?? 'Jesya Hartono';
              String userEmail =
                  prefs.getString('userEmail') ?? 'jesyahartono@gmail.com';

              return ListView(
                children: [
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 253, 8,
                          188), // Mengatur latar belakang menjadi merah muda
                    ),
                    accountName: Text(userName,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors
                                .white)), // Menampilkan nama pengguna dengan teks tebal dan warna putih
                    accountEmail: Text(userEmail,
                        style: TextStyle(
                            color: Colors
                                .white)), // Menampilkan email pengguna dengan warna putih
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://th.bing.com/th/id/OIP.Cb015w-4Lr_HCtoM2VHGgAHaHa?rs=1&pid=ImgDetMain'),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.history),
                    title: Text('Riwayat Belanja',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white)), // Teks tebal dan putih
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RiwayatPage(history: history),
                        ),
                      );
                    },
                    tileColor: Colors.transparent, // Default color
                    hoverColor: Colors.blue[100], // Biru muda saat di-hover
                  ),
                  ListTile(
                    leading: Icon(Icons.shopping_cart),
                    title: Text('Keranjang Belanja',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: const Color.fromARGB(
                                255, 255, 255, 255))), // Teks tebal dan putih
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => KeranjangPage(
                              cart: cart, addToHistory: addToHistory),
                        ),
                      );
                    },
                    tileColor: Colors.transparent, // Default color
                    hoverColor: Colors.blue[100], // Biru muda saat di-hover
                  ),
                  ListTile(
                    leading: Icon(Icons.question_answer),
                    title: Text('Pusat Bantuan (FAQ)',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white)), // Teks tebal dan putih
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PusatBantuanPage(),
                        ),
                      );
                    },
                    tileColor: Colors.transparent, // Default color
                    hoverColor: Colors.blue[100], // Biru muda saat di-hover
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Setting',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white)), // Teks tebal dan putih
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SettingPage(),
                        ),
                      );
                    },
                    tileColor: Colors.transparent, // Default color
                    hoverColor: Colors.blue[100], // Biru muda saat di-hover
                  ),
                  // Daftar menu lain
                ],
              );
            } else {
              return Center(child: Text("Error loading user data"));
            }
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selamat Berbelanja',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : errorMessage.isNotEmpty
                      ? Center(child: Text(errorMessage))
                      : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(10),
                                      ),
                                      child: Image.network(
                                        product['image'],
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Icon(
                                            Icons.error,
                                            size: 100,
                                            color: Colors.red,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          product['product'],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          formatCurrency(product['price']),
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: const Color.fromARGB(
                                                255, 50, 37, 149),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        ElevatedButton(
                                          onPressed: () {
                                            // Tambahkan produk ke keranjang
                                            addToCart(product);
                                          },
                                          child: Text(
                                            'Masukkan keranjang',
                                            style: TextStyle(
                                              fontWeight: FontWeight
                                                  .bold, // Membuat tulisan menjadi tebal
                                              color: Colors
                                                  .white, // Mengatur warna tulisan menjadi putih
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            minimumSize:
                                                Size(double.infinity, 36),
                                            backgroundColor: Colors
                                                .blue, // Mengatur warna tombol menjadi biru
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            // Menavigasi ke halaman ProductDetailPage dan mengirimkan data produk
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailPage(
                                                  productName:
                                                      product['product'] ??
                                                          'Unknown Product',
                                                  productPrice: formatCurrency(
                                                      product['price'] ?? '0'),
                                                  productImage:
                                                      product['image'] ?? '',
                                                  productDescription:
                                                      product['description'] ??
                                                          'No description',
                                                  productId:
                                                      product['idproduct'] ??
                                                          '0',
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Lihat detail',
                                            style: TextStyle(
                                              fontWeight: FontWeight
                                                  .bold, // Membuat tulisan menjadi tebal
                                              color: const Color.fromARGB(
                                                  255,
                                                  255,
                                                  255,
                                                  255), // Mengatur warna tulisan menjadi putih
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            minimumSize:
                                                Size(double.infinity, 36),
                                            backgroundColor: const Color
                                                .fromARGB(255, 253, 8,
                                                188), // Mengatur warna tombol menjadi biru
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
