import 'package:flutter/material.dart';

class TextInputValidator extends ValueNotifier<bool> {
  late final TextEditingController _controller;
  String get text => _controller.text;
  bool get hasError => super.value;
  TextEditingController get controller => _controller;

  set text(String value){
    _controller.text = value;
  }

  set hasError(bool value){
    super.value = value;
  }

  TextInputValidator({bool hasError = false, String? text}) :super(hasError) {
    _controller = TextEditingController(text: text);
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }
}
