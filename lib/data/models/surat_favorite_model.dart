class SuratFav {
  final int id;
  final int usrId;
  final String nomorSurat;
  final String namaSuratLatin;
  final String jumlahAyatSurat;

  SuratFav({
    required this.id,
    required this.usrId,
    required this.nomorSurat,
    required this.namaSuratLatin,
    required this.jumlahAyatSurat,
  });

  factory SuratFav.fromMap(Map<String, dynamic> map) {
    return SuratFav(
      id: map['id'],
      usrId: map['usrId'],
      nomorSurat: map['nomorSurat'],
      namaSuratLatin: map['namaSuratLatin'],
      jumlahAyatSurat: map['jumlahAyatSurat'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'usrId': usrId,
      'nomorSurat': nomorSurat,
      'namaSuratLatin': namaSuratLatin,
      'jumlahAyatSurat': jumlahAyatSurat,
    };
  }
}