import 'package:flutter/material.dart';

class RiwayatPage extends StatelessWidget {
  final List<Map<String, dynamic>> history;

  RiwayatPage({required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Belanja'),
      ),
      body: history.isEmpty
          ? Center(child: Text('Riwayat belanja Anda kosong'))
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, index) {
                final item = history[index];
                return ListTile(
                  leading: item['image'] != null
                      ? Image.network(
                          item['image'],
                          width: 50,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.error, color: Colors.red);
                          },
                        )
                      : Icon(Icons.shopping_bag),
                  title: Text(item['product'] ?? 'Produk'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Harga: Rp ${item['price'] ?? '0'}'),
                      Text('Quantity: ${item['quantity'] ?? 1}'),
                      Text(
                          'Waktu Checkout: ${item['checkout_time']}'), // Menampilkan waktu checkout
                    ],
                  ),
                );
              },
            ),
    );
  }
}
