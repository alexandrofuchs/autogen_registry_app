import 'dart:convert';

import 'package:plain_registry_app/core/response/i_response_result.dart';
import 'package:plain_registry_app/workflow/chat/domain/i_repositories/i_chat_repository.dart';
import 'package:plain_registry_app/workflow/chat/domain/models/chat.dart';
import 'package:plain_registry_app/workflow/chat/external/repository/saved_text_message_model.dart';
import 'package:plain_registry_app/workflow/chat/domain/models/text_message.dart';
import 'package:plain_registry_app/workflow/home/domain/models/registry_model.dart';
import 'package:sqflite/sqflite.dart';

part 'chat_local_db_adapter.dart';

class ChatRepository implements IChatRepository {
  final Database _database;

  ChatRepository(this._database);

  @override
  Future<IResponseResult<Chat>> loadPreviousChat(int id) async {
    try {
      final response = await _database.query('Registries',
          columns: ['content_data'], where: 'id = ?', whereArgs: [id]);
      return Success(ChatLocalDbAdapter.fromMap(response.first));
    } catch (e) {
      return Fail('Chat não encontrado', e);
    }
  } 

  @override
  Future<IResponseResult<int>> saveChat(Chat chat) async {
    try {
      final response = await _database.insert('Registries', chat.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      return Success(response);
    } catch (e) {
      return Fail('Não foi possível salvar o chat', e);
    }
  }
}
