import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  HttpService._internal();

  static final HttpService _instance = HttpService._internal();

  factory HttpService() {
    return _instance;
  }

  // General method for making GET requests
  Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse(endpoint));

    return _processResponse(response);
  }

  // General method for making POST requests
  Future<Map<String, dynamic>> post(String endpoint, dynamic data) async {
    final response = await http.post(
      Uri.parse(endpoint),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    return _processResponse(response);
  }

  // General method for making PUT requests
  Future<Map<String, dynamic>> put(String endpoint, dynamic data) async {
    final response = await http.put(
      Uri.parse(endpoint),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );

    return _processResponse(response);
  }

  // General method for making DELETE requests
  Future<Map<String, dynamic>> delete(String endpoint) async {
    final response = await http.delete(Uri.parse(endpoint));

    return _processResponse(response);
  }

  // A helper function to process the HTTP response
  Map<String, dynamic> _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to load data. Status Code: ${response.statusCode}');
    }
  }
}
