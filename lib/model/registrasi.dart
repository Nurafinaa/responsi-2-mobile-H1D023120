class Registrasi {
  bool? status;
  String? message;
  Map<String, dynamic>? data;

  Registrasi({this.status, this.message, this.data});

  factory Registrasi.fromJson(Map<String, dynamic> json) {
    return Registrasi(
      status: json['status'],           // BOOLEAN
      message: json['message'],         // STRING
      data: json['data'],               // OBJECT (opsional)
    );
  }
}
