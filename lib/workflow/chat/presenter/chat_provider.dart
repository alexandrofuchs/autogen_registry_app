import 'package:flutter/material.dart';
import 'package:plain_registry_app/workflow/chat/domain/i_repositories/i_chat_repository.dart';
import 'package:plain_registry_app/workflow/chat/domain/models/chat.dart';
import 'package:plain_registry_app/workflow/chat/domain/models/text_message.dart';

enum ChatProviderStatus {
  loading,
  failed,
  init,
  loaded,
}

class ChatProvider extends ChangeNotifier {
  final IChatRepository _repository;

  ChatProviderStatus _status = ChatProviderStatus.init;

  Chat? _chat;

  String _errorMessage = '';

  ChatProvider(this._repository);

  Chat get chat => _chat!;
  String get errorMessage => _errorMessage;
  ChatProviderStatus get status => _status;

  Future<void> loadChat(int id) async {
    final response = await _repository.loadPreviousChat(id);

    response.resolve(onFail: (err) {
      _errorMessage = err;
      _status = ChatProviderStatus.failed;
    }, onSuccess: (data) {
      _chat = data;
      _status = ChatProviderStatus.loaded;
    });
    notifyListeners();
    
  }

  Future<void> saveChat(Chat chat) async {
    final response = await _repository.saveChat(chat);
    response.resolve(
        onFail: (err) {
          debugPrint(err);
        },
        onSuccess: (data) {
          _chat = data;
          _status = ChatProviderStatus.loaded;
        });
    notifyListeners();
  }

  Future<void> saveMessages(List<TextMessage> messages) async {
    final response = await _repository.saveMessages(chat.id!, messages);
    response.resolve(
        onFail: (err) {
          debugPrint('could not save the message: $err');
        },
        onSuccess: (data) {
          debugPrint('saved chat message: $data');
          _chat = chat.copyWith(messages);
        });
    notifyListeners();
  }
}
