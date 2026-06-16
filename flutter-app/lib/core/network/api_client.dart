import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../errors/exceptions.dart';

class ApiClient {
  final http.Client _client;

  ApiClient(this._client);

  Future<dynamic> get(String endpoint) async {
    try {
      final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');
      final response = await _client.get(uri).timeout(
        const Duration(seconds: 10),
      );
      return _handleResponse(response);
    } on SocketException {
      throw NetworkException('Oops! Please check your internet connection.');
    } on http.ClientException {
      throw NetworkException('Hmm, we couldn\'t reach the server. Please try again.');
    }
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    try {
      final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');
      final response = await _client
          .post(uri, headers: {'Content-Type': 'application/json'}, body: jsonEncode(body))
          .timeout(const Duration(seconds: 10));
      return _handleResponse(response);
    } on SocketException {
      throw NetworkException('Oops! Please check your internet connection.');
    } on http.ClientException {
      throw NetworkException('Hmm, we couldn\'t reach the server. Please try again.');
    }
  }

  Future<dynamic> delete(String endpoint) async {
    try {
      final uri = Uri.parse('${ApiConstants.baseUrl}$endpoint');
      final response = await _client.delete(uri).timeout(
        const Duration(seconds: 10),
      );
      return _handleResponse(response);
    } on SocketException {
      throw NetworkException('Oops! Please check your internet connection.');
    } on http.ClientException {
      throw NetworkException('Hmm, we couldn\'t reach the server. Please try again.');
    }
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    }
    throw ServerException('Server error: ${response.statusCode}');
  }
}
