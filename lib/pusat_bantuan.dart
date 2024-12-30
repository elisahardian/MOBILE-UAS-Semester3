import 'package:flutter/material.dart';

class PusatBantuanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pusat Bantuan'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Judul atau Deskripsi Umum
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Selamat datang di Pusat Bantuan! Berikut adalah beberapa topik yang sering ditanyakan.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Pertanyaan Umum (FAQ)
            ListTile(
              title: Text(
                '1. Bagaimana cara melakukan pemesanan?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                  'Ikuti langkah-langkah untuk memesan produk di toko kami.'),
              onTap: () {
                _showsatuDetail(context, 'Cara Melakukan Pemesanan');
              },
            ),
            ListTile(
              title: Text(
                '2. Apa yang harus dilakukan jika pesanan saya tidak sampai?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle:
                  Text('Langkah-langkah untuk mengatasi masalah pengiriman.'),
              onTap: () {
                _showduaDetail(context, 'Pesanan Tidak Sampai');
              },
            ),
            ListTile(
              title: Text(
                '3. Bagaimana cara menggunakan kupon diskon?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Petunjuk penggunaan kode kupon pada pembelian.'),
              onTap: () {
                _showtigaDetail(context, 'Penggunaan Kupon Diskon');
              },
            ),
            ListTile(
              title: Text(
                '4. Bagaimana cara menghubungi customer service?',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Informasi kontak untuk customer service.'),
              onTap: () {
                _showempatDetail(context, 'Menghubungi Customer Service');
              },
            ),

            // Space for more questions or help topics
            SizedBox(height: 20),

            // Button untuk pergi ke halaman kontak
            ElevatedButton(
              onPressed: () {
                _showContactInfo(context);
              },
              child: Text('Hubungi Kami'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to show detail of the selected FAQ
  void _showsatuDetail(BuildContext context, String topic) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(topic),
          content: Text(
              'Ini adalah detail mengenai cara pemesanan di aplikasi penjualan Elektornik kami. 1. Buka aplikasi dan pilih produk atau layanan yang anda inginkan. 2. pilih opsi yang anda inginkan info detail atau masukan ke dalam keranjang. 3. klik tombol "masukan ke keranjang" jika anda ingin masukan ke keranjang. 4. pilih tombol checkout jika anda ingin langsung melakukan pembayaran. 5. anda bisa melihat pada layanan riwayat belanja untuk total jumlah yang harus anda bayar. Anda dapat memberikan informasi lebih lanjut tentang masalah atau pertanyaan ini di sini.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  void _showduaDetail(BuildContext context, String topic) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(topic),
          content: Text(
              'Ini adalah cara jika pesanan anda tidak sampai berikut. 1. Periksa status pesanan melalui aplikasi di menu "Pesanan Saya" untuk memastikan apakah pesanan sudah diproses atau sedang dalam pengiriman. 2. Jika status menunjukkan bahwa pesanan Anda sudah terkirim tetapi belum diterima, pastikan alamat pengiriman yang Anda berikan sudah benar dan lengkap. 3.Jika pesanan masih belum sampai setelah waktu estimasi pengiriman, silakan hubungi customer service kami melalui fitur "Hubungi Kami" di aplikasi atau melalui nomor telepon/email yang tersedia. 4. Tim kami akan segera membantu melacak pesanan Anda dan memberikan solusi terbaik. '),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  void _showtigaDetail(BuildContext context, String topic) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(topic),
          content: Text(
              'Ini adalah cara menggunakan kupon diskon di Aplikasi elektronik kami. 1.Pilih produk atau layanan yang ingin Anda pesan dan masukkan ke dalam keranjang. 2.Saat Anda berada di halaman pembayaran, cari kolom untuk memasukkan "Kode Kupon" atau "Voucher". 3.Masukkan kode kupon yang valid di kolom tersebut dan klik "Terapkan". 3.Diskon yang sesuai dengan kupon Anda akan langsung diterapkan pada total pembayaran. 4.Lanjutkan proses pembayaran seperti biasa untuk menyelesaikan pesanan Anda. '),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  void _showempatDetail(BuildContext context, String topic) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(topic),
          content: Text(
              'Ini adalah cara menghubungi customer service jika anda mengalami masalah saat menggunakan aplikasi elektronik kami. 1. Buka aplikasi dan pilih menu " Bnatuan" atau "Hubungi kami" 2. Hubungi nomor customer service kami di nomor telepon  179-185-0001. 3. Kirimkan email ke @elektronikjaya dengan menyertakan pertanyaan atau keluhan anda, dan tim kami akan merespons dalam waktu 24 jam. '),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

  // Function to show contact information
  void _showContactInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hubungi Kami'),
          content: Text(
              'Jika Anda membutuhkan bantuan lebih lanjut, Anda dapat menghubungi customer service kami di:\n\nEmail: supportcustomer@tokotas.com\nNomor Telepon: 179-185-0001\nJam Operasional: Senin - Jumat, 09:00 - 16:00'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Tutup'),
            ),
          ],
        );
      },
    );
  }
}
