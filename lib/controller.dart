import 'dart:async';
import 'dart:convert';
import 'package:album/network.dart';
import 'global.dart';
import 'model.dart';

class UsersApi {
  Future<List<User>> getUsers() async {
    NetworkLayer networkLayer = NetworkLayer();
    var response = await networkLayer.get(Paths.users);
    var users = json.decode(response) as List;
    return users.map((e) => User.fromJson(e)).toList();
  }
}