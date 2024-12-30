<?php
// mengatur header agar dapat diakses oleh berbagai sumber (CORS)
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

//menghubungkan ke database
require "connect.php";

if ($_SERVER['REQUEST_METHOD'] == "POST") {
    $response = array(); //inisialisasi array untuk menyimpan respon

    //mengambil email dan password dari POST request
    $email = $_POST['email'];
    $password = $_POST['password']; // password dari input form

    // membuat query untuk mengambil data pengguna berdasarkan email
    $cek = "SELECT * FROM users WHERE email='$email'";

    // menjalankan query
    $result = mysqli_query($connect, $cek);

    // mengecak apakah hasil query valid
    if ($result && mysqli_num_rows($result) > 0) {
        // mengambil data pengguna dari database
        $row = mysqli_fetch_assoc($result);

        // memverifikasi password dengan hash yang tersimpan didatabase
        if (password_verify($password, $row['password'])) {
            // jika password cocok, login berhasil
            $response['value'] = 1;
            $response['message'] = 'Login Berhasil';
        } else {
            // jika password tidak cocok
            $response['value'] = 0;
            $response['message'] = 'Login gagal. Password salah.';
        }
    } else {
        // jika email tidak ditemukan di database
        $response['value'] = 0;
        $response['message'] = "Login gagal. Email tidak ditemukan.";
    }

    // Mengembalkan respons dalam format JSON
    echo json_encode($response);
} else {
    // jika request method bukan POST
    $response['value'] = 0;
    $response['message'] = "Permintaan tidak valid.";
    echo json_encode($response);
}
?>
