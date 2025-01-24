import 'dart:async';

import 'package:plain_registry_app/workflow/chat/domain/models/text_message.dart';
import 'package:plain_registry_app/workflow/chat/domain/i_services/i_text_message_service.dart';

class TextMessageController {
  final ITextMessageService _service;

  final _streamController = StreamController<List<TextMessage>>(
    onPause: () => print('Paused'),
    onResume: () => print('Resumed'),
    onCancel: () => print('Cancelled'),
    onListen: () => print('Listens'),
  );

  Stream<List<TextMessage>> get onNewMessage => _streamController.stream;

  TextMessageController(this._service);

  generateAnswer(List<TextMessage> historical) async {
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
