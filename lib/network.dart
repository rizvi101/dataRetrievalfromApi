import 'package:http/http.dart' as http;

class NetworkLayer {
  Future<String> get(url, {Map<String, String> queryParameters}) async {
    var response = await http.get(url);
    if (response.statusCode >= 200 && response.statusCode <= 209) {
      return response.body;
    }
    // Create different error messages based on different status codes.
    throw Exception('My error');
  }
}
