class UserModel {
  String? name;
  String? phone;
  String? email;
  String? img;
  String? uId;
  String? password;

  UserModel(
      {this.name,
        this.password,
        this.phone,
        this.img,
        this.email,
        this.uId,
        });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    uId = json['uId'];
    img = json['img'];
    password = json['password'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'uId': uId,
      'img': img,
      'password': password,
    };
  }
}
