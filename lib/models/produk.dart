class Produk {
  int? id;
  String? kode;
  String? nama;
  int? harga;
  String? gambar; // Properti baru

  Produk({this.id, this.kode, this.nama, this.harga, this.gambar});

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()),
      kode: json['kode'].toString(),
      nama: json['nama'].toString(),
      harga: json['harga'] is int ? json['harga'] : int.tryParse(json['harga'].toString()),
      gambar: json['gambar']?.toString(), // Ambil data nama gambar
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'kode': kode,
      'nama': nama,
      'harga': harga,
      'gambar': gambar, // Sertakan di JSON
    };
  }
}