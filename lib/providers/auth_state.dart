import 'package:flutter/foundation.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/models/skill.dart';
import 'package:myportofolio_mobile/models/experience.dart';

class AuthState extends ChangeNotifier {
  final ApiClient _apiClient = ApiClient();

  bool _isAuthenticated = false;
  bool _isLoading = false;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;

  Future<void> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _apiClient.login(username, password);
      _isAuthenticated = true;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<List<Skill>> getSkills() {
    return _apiClient.getSkills();
  }

  Future<List<Experience>> getExperiences() {
    return _apiClient.getExperiences();
  }

  Future<void> createExperience(
    Map<String, dynamic> experience,
  ) {
    return _apiClient.createExperience(experience);
  }

  Future<void> logout() async {
    await _apiClient.logout();
    _isAuthenticated = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _apiClient.dispose();
    super.dispose();
  }
}