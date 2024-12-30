<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

require "connect.php";

if ($_SERVER['REQUEST_METHOD'] == "POST") {
    $email = $_POST['email'] ?? null;
    $newPassword = $_POST['new_password'] ?? null;

    if (!empty($email) && !empty($newPassword)) {
        // Cek apakah email ada di database
        $query = "SELECT * FROM users WHERE email = ?";
        $stmt = $connect->prepare($query);
        $stmt->bind_param("s", $email);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            // Hash password baru
            $hashedPassword = password_hash($newPassword, PASSWORD_DEFAULT);
            $updateQuery = "UPDATE users SET password = ? WHERE email = ?";
            $updateStmt = $connect->prepare($updateQuery);
            $updateStmt->bind_param("ss", $hashedPassword, $email);

            if ($updateStmt->execute()) {
                echo json_encode([
                    "status" => "success",
                    "message" => "Password berhasil direset.",
                ]);
            } else {
                echo json_encode([
                    "status" => "error",
                    "message" => "Gagal mereset password.",
                ]);
            }
        } else {
            echo json_encode([
                "status" => "error",
                "message" => "Email tidak ditemukan.",
            ]);
        }
    } else {
        echo json_encode([
            "status" => "error",
            "message" => "Email dan password tidak boleh kosong.",
        ]);
    }
} else {
    echo json_encode([
        "status" => "error",
        "message" => "Metode tidak valid.",
    ]);
}
?>
