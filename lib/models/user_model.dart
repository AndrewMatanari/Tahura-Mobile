class UserModel {
  int Id;
  String name;
  String email;
  String password;

  UserModel(
      {required this.Id,
      required this.name,
      required this.email,
      required this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        Id: json['Id'],
        name: json['name'],
        email: json['email'],
        password: json['password'],
      );

  Map<String, dynamic> toJson() => {
        'Id': Id,
        'name': name,
        'email': email,
        'password': password,
      };
}
