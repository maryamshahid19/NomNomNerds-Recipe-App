class UserModel {
  int? userid;
  final String username;
  final String email;
  final String password;

  UserModel(
      {required this.userid,
      required this.username,
      required this.email,
      required this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      userid: json['userid'],
      username: json['username'],
      email: json['email'],
      password: json['password']);

  Map<String, dynamic> toMap() => {
        //'userid': userid,
        'username': username,
        'email': email,
        'password': password
      };
}
