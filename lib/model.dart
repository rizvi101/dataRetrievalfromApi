class Album {
  final String name;
  final String username;
  final String email;

  Album({this.name, this.username, this.email});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }
}
