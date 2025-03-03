import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../models/template_model.dart';

class TemplateService {
  String? _baseUrl;

  void initialize(String baseUrl) {
    _baseUrl = baseUrl;
  }

  Future<List<Template>> fetchTemplates() async {
    if (_baseUrl == null) {
      throw Exception('Service not initialized. Call initialize() first.');
    }

    try {
      final response = await http.get(Uri.parse(_baseUrl!));
      if (response.statusCode == 200) {
        List<dynamic> jsonData = json.decode(response.body);
        debugPrint('API Response: ${response.body}');
        return jsonData.map((json) => Template.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load templates: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to fetch templates: $e');
    }
  }
} 