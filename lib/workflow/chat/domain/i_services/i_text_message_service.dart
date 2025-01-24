import 'package:plain_registry_app/core/response/i_response_result.dart';
import 'package:plain_registry_app/workflow/chat/domain/models/text_message.dart';

abstract class ITextMessageService {
  Future<IResponseResult<TextMessage>> generateAnswer(List<TextMessage> historical);
}