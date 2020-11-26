import 'package:album/network.dart';

NetworkLayer networkLayer = NetworkLayer();

abstract class Paths {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/';
  static const String users = baseUrl + 'users';
}