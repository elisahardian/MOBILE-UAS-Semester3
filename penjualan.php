<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

require "connect.php";

if ($_SERVER['REQUEST_METHOD'] == "POST") {
    
    $response = array();

    $input = json_decode(file_get_contents('php://input'), true);
    $purchases = $input['purchases'] ?? [];

    if (!empty($purchases)) {
        foreach ($purchases as $purchase) {
            $id_produk = $purchase['id_produk'];
            $harga_produk = floatval($purchase['harga_produk']) / 100;
            $quantity = $purchase['quantity'];
            $tanggal = date('Y-m-d');

            $stmt = $connect->prepare("INSERT INTO jual (tgljual, idproduct, price, quantity) VALUES (?, ?, ?, ?)");
            $stmt->bind_param("ssdi", $tanggal, $id_produk, $harga_produk, $quantity);

            if (!$stmt->execute()) {
                $response['value'] = 0;
                $response['message'] = 'Gagal menyimpan data: ' . $stmt->error;
                echo json_encode($response);
                exit;
            }
        }

        $response['value'] = 1;
        $response['message'] = 'Semua data berhasil disimpan';
    } else {
        $response['value'] = 0;
        $response['message'] = 'Data pembelian kosong';
    }

    echo json_encode($response);
}
?>
