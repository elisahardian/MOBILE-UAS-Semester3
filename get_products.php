<?php
header("Access-Control-Allow-Origin: *");
header("Content-Type: application/json; charset=UTF-8");

require "connect.php"; // koneksi ke database

$query = "SELECT * FROM namaproduct";
$result = mysqli_query($connect, $query);


$products = array();

while ($row = mysqli_fetch_assoc($result)) {
    $products[] = $row;
}

echo json_encode($products); // Mengembalikan produk dalam format JSON
?>