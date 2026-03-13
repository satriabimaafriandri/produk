<?php
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
header("Access-Control-Allow-Methods: POST, OPTIONS");
if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') { exit(); }
header('Content-Type: application/json');

include 'konekdb.php';
$data = json_decode(file_get_contents('php://input'), true);

if (!isset($data['id']) || !isset($data['kode']) || !isset($data['nama']) || !isset($data['harga'])) {
    echo json_encode(['error' => 'Data tidak lengkap']);
    exit;
}

$id = (int)$data['id'];
$kode = $data['kode'];
$nama = $data['nama'];
$harga = (int)$data['harga'];
$gambar_baru = null;

// Jika user mengupload gambar baru
if (isset($data['gambar']) && !empty($data['gambar'])) {
    $gambar_base64 = $data['gambar'];
    $gambar_baru = time() . '.jpg';
    $path = 'uploads/' . $gambar_baru;
    file_put_contents($path, base64_decode($gambar_base64));

    // Hapus gambar lama (Opsional tapi disarankan)
    $stmtCek = $konekdb->prepare("SELECT gambar FROM produk WHERE id = :id");
    $stmtCek->bindParam(':id', $id);
    $stmtCek->execute();
    $lama = $stmtCek->fetch(PDO::FETCH_ASSOC);
    if ($lama && $lama['gambar'] && file_exists('uploads/' . $lama['gambar'])) {
        unlink('uploads/' . $lama['gambar']);
    }
}

try {
    if ($gambar_baru) {
        $stmt = $konekdb->prepare("UPDATE produk SET kode = :kode, nama = :nama, harga = :harga, gambar = :gambar WHERE id = :id");
        $stmt->bindParam(':gambar', $gambar_baru);
    } else {
        // Jika tidak ada gambar baru, update data teks saja
        $stmt = $konekdb->prepare("UPDATE produk SET kode = :kode, nama = :nama, harga = :harga WHERE id = :id");
    }

    $stmt->bindParam(':id', $id);
    $stmt->bindParam(':kode', $kode);
    $stmt->bindParam(':nama', $nama);
    $stmt->bindParam(':harga', $harga);  
    $stmt->execute();
    
    echo json_encode(['pesan' => 'Sukses update data']);
} catch (PDOException $e) {
    echo json_encode(['error' => 'Gagal update: ' . $e->getMessage()]);
}
?>