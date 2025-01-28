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
      // var response = await http.post(_baseURI, body: jsonEncode(contentData));
      // print('Response status: ${response.statusCode}');
      // return jsonDecode(response.body);
      final content = jsonDecode(await rootBundle.loadString('mocks/gemini_markdown_sample.json'));

      return {
        "candidates": [
          {
            "content": {
              "parts": [
                {"text": content['content']}
              ],
              "role": "model"
            },
            "finishReason": "STOP",
            "avgLogprobs": -0.003488737803239089
          }
        ],
        "usageMetadata": {
          "promptTokenCount": 12,
          "candidatesTokenCount": 13,
          "totalTokenCount": 25
        },
        "modelVersion": "gemini-1.5-flash"
      };
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
