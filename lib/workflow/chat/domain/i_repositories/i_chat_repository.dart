import 'package:plain_registry_app/core/response/i_response_result.dart';
import 'package:plain_registry_app/workflow/chat/domain/models/chat.dart';
import 'package:plain_registry_app/workflow/chat/domain/models/text_message.dart';

abstract class IChatRepository {
  Future<IResponseResult<Chat>> saveChat(Chat chat);
  Future<IResponseResult<int>> saveMessages(int chatId, List<TextMessage> messages);
  Future<IResponseResult<Chat>> loadPreviousChat(int chatId);
}