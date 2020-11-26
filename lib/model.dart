class User {
  final String name;
  final String username;
  final String email;

  User({this.name, this.username, this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }
}
