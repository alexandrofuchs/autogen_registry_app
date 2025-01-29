import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class GeminiApi {
  GeminiApi._privateConstructor();

  static final GeminiApi _instance = GeminiApi._privateConstructor();
  static GeminiApi get instance => _instance;

  late final Uri _baseURI;

  Future<void> loadCredentials() async {
    try {
      final credentials =
          jsonDecode(await rootBundle.loadString('.env/credentials.json'));
      _baseURI = Uri.https(credentials['base_url'], credentials['path'],
          credentials['query_params']);
    } catch (e) {
      debugPrint(e.toString());
      _baseURI = Uri();
    }
  }

  Future<dynamic> generateText(Map<String, dynamic> contentData) async {
    try {
      var response = await http.post(_baseURI, body: jsonEncode(contentData));
      debugPrint('Response status: ${response.statusCode}');
      return jsonDecode(response.body);
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
