import 'package:plain_registry_app/core/response/i_response_result.dart';
import 'package:plain_registry_app/workflow/chat/domain/models/chat.dart';

abstract class IChatRepository {
  Future<IResponseResult<int>> saveChat(Chat chat);
  Future<IResponseResult<Chat>> loadPreviousChat(int id);
}