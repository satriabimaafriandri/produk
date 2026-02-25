void main() {
  
  var profil = DataDiri('Satria Bima Baja Hitam', 'XII RPL 2', 'Naik Gunung', '169cm', 'Hari Terakhir Peradaban - FSTVLS');
  
  
  profil.tampilkan();
}

class DataDiri {
  String nama;
  String kelas;
  String hobi; 
  String tinggi;
  String LaguFavorit;

  DataDiri(this.nama, this.kelas, this.hobi, this.tinggi, this.LaguFavorit);

  void tampilkan() {
    print('=== DATADIRI===');
    print('Nama    : $nama');
    print('Kelas   : $kelas');
    print('Hobi    : $hobi');
    print('Tinggi  : $tinggi');
    print('LaguFavorit  : $LaguFavorit');
  }
}