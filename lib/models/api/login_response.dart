class LoginResponse {
  String? message;
  User? user;
  String? token;

  LoginResponse({this.message, this.user, this.token});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'] ?? 'Terjadi kesalahan yang tak terduga';
    token = json['token'];

    if (json['user'] != null) {
      user = User.fromJson(json['user']);
    }
  }
}

class User {
  int? id;
  String? name;
  String? email;

  User({this.id, this.name, this.email});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? 'Nama tidak diketahui';
    email = json['email'] ?? 'Email tidak diketahui';
  }
}
