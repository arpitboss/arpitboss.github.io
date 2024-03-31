import 'dart:convert';

import 'package:atg_assignment/models/lessons.dart';
import 'package:atg_assignment/models/programs.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<Programs?> fetchPrograms() async {
    final response = await http.get(
        Uri.parse('https://632017e19f82827dcf24a655.mockapi.io/api/programs'));

    if (response.statusCode == 200) {
      return Programs.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load programs');
    }
  }

  static Future<Lessons?> fetchLessons() async {
    final response = await http.get(
        Uri.parse('https://632017e19f82827dcf24a655.mockapi.io/api/lessons'));

    if (response.statusCode == 200) {
      return Lessons.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load lessons');
    }
  }
}
