class Inventaris {
  int? id;
  String? nama;
  int? harga;
  int? jumlah;
  String? tanggalMasuk;
  String? tanggalKedaluwarsa;

  Inventaris({
    this.id,
    this.nama,
    this.harga,
    this.jumlah,
    this.tanggalMasuk,
    this.tanggalKedaluwarsa,
  });

  factory Inventaris.fromJson(Map<String, dynamic> json) {
    return Inventaris(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      nama: json['nama'],
      harga: json['harga'] != null ? int.tryParse(json['harga'].toString()) : null,
      jumlah: json['jumlah'] != null ? int.tryParse(json['jumlah'].toString()) : null,
      tanggalMasuk: json['tanggal_masuk'],
      tanggalKedaluwarsa: json['tanggal_kedaluwarsa'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'harga': harga,
      'jumlah': jumlah,
      'tanggal_masuk': tanggalMasuk,
      'tanggal_kedaluwarsa': tanggalKedaluwarsa,
    };
  }
}