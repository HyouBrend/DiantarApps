class Kontak {
  final String displayName;
  final String kontakID;
  final String type;
  final String latitude;
  final String lokasi;
  final String longitude;

  Kontak({
    required this.displayName,
    required this.kontakID,
    required this.type,
    required this.latitude,
    required this.lokasi,
    required this.longitude,
  });

  Map<String, dynamic> toJson() {
    return {
      'DisplayName': displayName,
      'KontakID': kontakID,
      'Type': type,
      'latitude': latitude,
      'lokasi': lokasi,
      'longitude': longitude,
    };
  }
}

class Driver {
  final int karyawanID;
  final String nama;
  final String noHP;
  final String posisi;
  final List<Kontak> kontaks;

  Driver({
    required this.karyawanID,
    required this.nama,
    required this.noHP,
    required this.posisi,
    required this.kontaks,
  });

  Map<String, dynamic> toJson() {
    return {
      'KaryawanID': karyawanID,
      'Nama': nama,
      'NoHP': noHP,
      'Posisi': posisi,
      'Kontaks': kontaks.map((k) => k.toJson()).toList(),
    };
  }
}
