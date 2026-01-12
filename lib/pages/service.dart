import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Service {
  final String baseUrl =
      "https://springboot-register-production.up.railway.app/api"; //http://10.0.2.2:8080/api (for emulator)

  // 🔐 LOGIN
  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"username": email, "password": password}),
      );

      if (response.statusCode == 200) {
        final token = jsonDecode(response.body)["token"];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("jwt", token);
        return true;
      } else {
        print("Login failed: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Login error: $e");
      return false;
    }
  }

  // 📝 REGISTER
  Future<bool> registerUser(
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/register"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        print("Register failed: ${response.body}");
        return false;
      }
    } catch (e) {
      print("Register error: $e");
      return false;
    }
  }

  // 🔓 LOGOUT
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("jwt");
  }

  // ✅ Get JWT for protected API calls
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("jwt");
  }

  // 🔐 Get protected data example
  Future<Map<String, dynamic>> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("jwt");

    if (token == null) throw Exception("User not logged in");

    final response = await http.get(
      Uri.parse("$baseUrl/profile"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      throw Exception("Unauthorized: Token invalid or expired");
    } else {
      throw Exception("Failed: ${response.body}");
    }
  }
}
