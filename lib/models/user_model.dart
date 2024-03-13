class UserModel {
  int? id;
  String? nama;
  String? email;
  String? role;
  // ignore: non_constant_identifier_names
  String? access_token;

  // ignore: non_constant_identifier_names
  UserModel({this.id, this.nama, this.email, this.role, this.access_token});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    email = json['email'];
    role = json['role'];
    access_token = json['access_token'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama': nama,
      'email': email,
      'role': role,
      'token': access_token
    };
  }
}
