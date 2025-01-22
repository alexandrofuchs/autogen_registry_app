import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatProvider extends ChangeNotifier {
  String _data = '';

  ChatProvider();


  String get data => _data;

  loadData() async {
    _data = await jsonDecode(
        await rootBundle.loadString('mocks/gemini_markdown_sample3.json'))['content'];
    notifyListeners();
  }
}
