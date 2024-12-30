<?php
// Koneksi ke database
require "connect.php"; // koneksi ke database

// Ambil data riwayat pembelian
$sql = "SELECT * FROM penjualan";
$result = $conn->query($sql);

$data = array();
while ($row = $result->fetch_assoc()) {
    $data[] = $row;
}

// Kirimkan data dalam format JSON
echo json_encode($data);

$conn->close();
?>
