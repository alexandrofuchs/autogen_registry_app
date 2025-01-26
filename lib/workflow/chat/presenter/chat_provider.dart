import 'package:flutter/material.dart';
import 'package:plain_registry_app/workflow/chat/domain/i_repositories/i_chat_repository.dart';
import 'package:plain_registry_app/workflow/chat/domain/models/chat.dart';

enum ChatProviderStatus {
  loading,
  failed,
  initialized,
  loaded,
}

class ChatProvider extends ChangeNotifier {
  final IChatRepository _repository;

  ChatProviderStatus _status = ChatProviderStatus.loading;

  Chat? _chat;

  String _errorMessage = '';

  ChatProvider(this._repository);

  Chat get chat => _chat!;
  String get errorMessage => _errorMessage;
  ChatProviderStatus get status => _status;

  Future<void> loadChat(int id) async {
    // _status = ChatProviderStatus.loading;
    // notifyListeners();

    final response = await _repository.loadPreviousChat(id);

    response.resolve(onFail: (err) {
      _errorMessage = err;
      _status = ChatProviderStatus.failed;
      notifyListeners();
    }, onSuccess: (data) {
      _chat = data;
      _status = ChatProviderStatus.loaded;
      notifyListeners();
    });
    
  }

  Future<void> saveChat(Chat chat) async {
    final response = await _repository.saveChat(chat);
    response.resolve(
        onFail: (err) {},
        onSuccess: (data) {
          _chat = chat;
          _status = ChatProviderStatus.initialized;
        });
    notifyListeners();
  }
}
