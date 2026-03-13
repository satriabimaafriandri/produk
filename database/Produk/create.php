<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
header("Access-Control-Allow-Methods: POST, OPTIONS");
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') { exit(); }
header('Content-Type: application/json');

include 'konekdb.php';
$data = json_decode(file_get_contents('php://input'), true);

if (!isset($data['kode']) || !isset($data['nama']) || !isset($data['harga'])) {
    echo json_encode(['error' => 'Kehilangan baris yang di butuhkan']);
    exit;
}

$kode = $data['kode'];
$nama = $data['nama'];
$harga = $data['harga'];
$nama_file = null;

// Proses Gambar jika ada
if (isset($data['gambar']) && !empty($data['gambar'])) {
    $gambar_base64 = $data['gambar'];
    $nama_file = time() . '.jpg'; // Nama file unik berdasarkan waktu
    $path = 'uploads/' . $nama_file;
    
    // Buat folder uploads jika belum ada
    if (!file_exists('uploads')) {
        mkdir('uploads', 0777, true);
    }
    file_put_contents($path, base64_decode($gambar_base64));
}

try {
    $stmt = $konekdb->prepare("INSERT INTO produk (kode, nama, harga, gambar) VALUES (:kode, :nama, :harga, :gambar)");
    $stmt->bindParam(':kode', $kode);
    $stmt->bindParam(':nama', $nama);
    $stmt->bindParam(':harga', $harga);
    $stmt->bindParam(':gambar', $nama_file);
    $stmt->execute();

    echo json_encode(['Sukses' => 'Produk Berhasil di tambahken', 'id' => $konekdb->lastInsertId()]);
} catch (PDOException $e) {
    echo json_encode(['error' => $e->getMessage()]);
}
?>