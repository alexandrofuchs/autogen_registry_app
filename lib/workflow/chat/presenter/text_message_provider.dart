import 'dart:async';

import 'package:plain_registry_app/workflow/chat/domain/models/text_message.dart';
import 'package:plain_registry_app/workflow/chat/domain/i_services/i_text_message_service.dart';

class TextMessageController {
  final ITextMessageService _service;

  StreamController<List<TextMessage>> _controller = StreamController.broadcast();

  Stream<List<TextMessage>> get onNewMessage => _controller.stream;

  TextMessageController(this._service);

  generateAnswer(List<TextMessage> historical) async {
    final response = await _service.generateAnswer(historical);

    response.resolve(
        onFail: (err) {}, onSuccess: (data) => _controller.add(
          List.from(historical)..add(data),
        ));
  }

  void dispose(){
    _controller.close();
  }
}
