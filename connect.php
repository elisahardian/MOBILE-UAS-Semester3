<?php
    $connect=new
    mysqli("localhost", "root", "", "db_uasmobile");
    if($connect) {
    } else { 
        echo "koneksi gagal"; //opsional hanya untuk debugging.
        exit();
    }
?>