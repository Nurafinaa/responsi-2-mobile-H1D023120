class Login {
  bool? status;
  String? message;
  UserData? data;

  Login({this.status, this.message, this.data});

  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }
}

class UserData {
  int? id;
  String? nama;
  String? email;

  UserData({this.id, this.nama, this.email});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null, // ✅ FIX
      nama: json['nama'],
      email: json['email'],
    );
  }
}