import 'dart:async';

import 'package:plain_registry_app/workflow/chat/domain/models/text_message.dart';
import 'package:plain_registry_app/workflow/chat/domain/i_services/i_text_message_service.dart';

class TextMessageController {
  final ITextMessageService _service;
  
  late final StreamController<List<TextMessage>> _streamController;

  Stream<List<TextMessage>> get onNewMessage => _streamController.stream;
  StreamController<List<TextMessage>> get streamController => _streamController;

  TextMessageController(this._service){
    _streamController = StreamController<List<TextMessage>>.broadcast();
  }

  set historical(List<TextMessage> messages){
    _streamController.add(messages);
  }

  Future<void> generateAnswer(List<TextMessage> historical) async {
    final response = await _service.generateAnswer(historical);

    response.resolve(
        onFail: (err) {}, onSuccess: (data) => 
          _streamController.add(List.from(historical)..add(data)..sort((a,b) => a.id.compareTo(b.id)),
        ));
  }

  void dispose(){
    _streamController.close();
  }
}
