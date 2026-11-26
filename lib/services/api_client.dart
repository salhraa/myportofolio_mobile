import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myportofolio_mobile/config.dart';
import 'package:myportofolio_mobile/models/skill.dart';
import 'package:myportofolio_mobile/models/experience.dart';

class ApiException implements Exception {
  final int statusCode;
  final String message;

  ApiException(this.statusCode, this.message);

  @override
  String toString() => 'ApiException: $statusCode - $message';
}

class ApiClient {
  final http.Client _client;

  ApiClient({http.Client? client}) : _client = client ?? http.Client();

  String? _token;

  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    if (_token != null) 'Authorization': 'Token $_token',
  };

  // GET Skills
  Future<List<Skill>> getSkills() async {
    final response = await _client.get(
      Uri.parse('$apiBaseUrl/api/v1/skills/'),
      headers: _headers,
    );

    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }

    final List<dynamic> data = jsonDecode(response.body);

    return data
        .map((item) => Skill.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  // GET Experiences
  Future<List<Experience>> getExperiences() async {
    final response = await _client.get(
      Uri.parse('$apiBaseUrl/api/v1/experiences/'),
      headers: _headers,
    );

    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }

    final List<dynamic> data = jsonDecode(response.body);

    return data
        .map((item) => Experience.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  // POST Experience
  Future<void> createExperience(Map<String, dynamic> experience) async {
    final response = await _client.post(
      Uri.parse('$apiBaseUrl/api/v1/experiences/'),
      headers: _headers,
      body: jsonEncode(experience),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }
  }

  // Login
  Future<void> login(String username, String password) async {
    final response = await _client.post(
      Uri.parse('$apiBaseUrl/api/v1/auth/token/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode != 200) {
      throw ApiException(response.statusCode, response.body);
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    _token = data['token'] as String;
  }

  // Logout
  Future<void> logout() async {
    if (_token == null) return;

    final response = await _client.post(
      Uri.parse('$apiBaseUrl/api/v1/auth/logout/'),
      headers: _headers,
    );

    if (response.statusCode != 204) {
      throw ApiException(response.statusCode, response.body);
    }

    _token = null;
  }

  void dispose() {
    _client.close();
  }
}
