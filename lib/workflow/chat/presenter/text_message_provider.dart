import 'dart:async';

import 'package:plain_registry_app/workflow/chat/domain/models/text_message.dart';
import 'package:plain_registry_app/workflow/chat/domain/i_services/i_text_message_service.dart';

class TextMessageController {
  final ITextMessageService _service;

  final _streamController = StreamController<List<TextMessage>>();

  Stream<List<TextMessage>> get onNewMessage => _streamController.stream;

  TextMessageController(this._service);

  set historical(List<TextMessage> messages){
    _streamController.add(messages);
  }

  Future<void> generateAnswer(List<TextMessage> historical) async {
    final response = await _service.generateAnswer(historical);

    response.resolve(
        onFail: (err) {}, onSuccess: (data) => 
          _streamController.add(List.from(historical)..add(data),
        ));
  }

  void dispose(){
    _streamController.close();
  }
}
