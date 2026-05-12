class UserModel {
  final String name;
  final String email;
  final String? image;
  final String? token;

  UserModel({
    required this.name,
    required this.email,
    this.image,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'] ,
      image: json['image'],
      token: json['token'],
    );
  }
}
