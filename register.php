<?php
// mengatur header agar dapat diakses oleh berbagai sumber (CORS)
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// menghubungkan ke database
require "connect.php";

if ($_SERVER['REQUEST_METHOD'] == "POST") {
    $response = array(); // inisialisasi array untuk respon

    // mengambil data dari post request
    $email = $_POST['email'] ?? null;
    $password = $_POST['password'] ?? null;
    $nama = $_POST['nama'] ?? null;
    $alamat = $_POST['alamat'] ?? null;
    $telepon = $_POST['telepon'] ?? null;
}

// cek apakah semua field terisi
if (!empty($email) && !empty($password) && !empty($nama) && !empty($alamat) && !empty($telepon)) {
    //hashing password sebelum menyimpan
    $hashed_password = password_hash($password, PASSWORD_DEFAULT);

    //menggunakan prepared statement untuk menghindari SQL Injection
    // mengubah field 'createdDate' dengan nilai default dari fungsi NOW() MYSQL
    $stmt = $connect->prepare("INSERT INTO users (email, password, nama, alamat, telepon, createdDate) VALUES (?, ?, ?, ?, ?, NOW())");
    $stmt->bind_param("sssss", $email, $hashed_password, $nama, $alamat, $telepon); // 's'=string

    //menjalankan query
    if ($stmt->execute()) {
        //jika penyimpanan berhasil
        $response['value'] = 1;
        //$response['success'] = true;
        $response['message'] = 'Register Berhasil diproses';
        

    } else {
        // jika terjadi kesalahan saat menyimpan
        $response['value'] = 0;
        $response['message'] = 'Gagal menyimpan data' . $stmt->error;
    }
    $stmt->close(); // menutup statement
} else {
    //jika request method bukan post
    $response['value'] = 0;
    $response['message'] = 'Permintaan tidak valid';
    echo json_encode($response);
}

?>
