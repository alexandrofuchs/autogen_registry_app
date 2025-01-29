import 'dart:convert';

import 'package:autogen_registry_app/core/response/i_response_result.dart';
import 'package:autogen_registry_app/workflow/chat/domain/i_repositories/i_chat_repository.dart';
import 'package:autogen_registry_app/workflow/chat/domain/models/chat.dart';
import 'package:autogen_registry_app/workflow/chat/domain/models/text_message.dart';
import 'package:autogen_registry_app/workflow/home/domain/models/registry_model.dart';
import 'package:sqflite/sqflite.dart';

part 'chat_local_db_adapter.dart';

class ChatRepository implements IChatRepository {
  final Database _database;

  ChatRepository(this._database);

  @override
  Future<IResponseResult<Chat>> loadPreviousChat(int id) async {
    try {
      final response = await _database.query('Registries', where: 'id = ?', whereArgs: [id]);
      return Success(ChatLocalDbAdapter.fromMap(response.first));
    } catch (e) {
      return Fail('Chat não encontrado', e);
    }
  } 

  @override
  Future<IResponseResult<Chat>> saveChat(Chat chat) async {
    try {
      final response = await _database.insert('Registries', chat.toMap(), conflictAlgorithm: ConflictAlgorithm.fail);
      return await loadPreviousChat(response);
    } catch (e) {
      return Fail('Não foi possível salvar o chat', e);
    }
  }
  
  @override
  Future<IResponseResult<int>> saveMessages(int chatId, List<TextMessage> messages) async {
    try {
      final response = await _database.update('Registries', {
        'content_data': jsonEncode(messages.map((e) => e.toMap()).toList()),
      }, where: 'id = ?', whereArgs: [chatId], );
      return Success(response);
    } catch (e) {
      return Fail('Não foi possível salvar o chat', e);
    }
  }
}
