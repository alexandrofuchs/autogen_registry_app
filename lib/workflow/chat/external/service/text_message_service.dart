import 'package:plain_registry_app/core/external/gemini_api.dart';
import 'package:plain_registry_app/core/response/i_response_result.dart';
import 'package:plain_registry_app/workflow/chat/domain/models/text_message.dart';
import 'package:plain_registry_app/workflow/chat/domain/i_services/i_text_message_service.dart';

part 'text_message_api_adapter.dart';

class TextMessageService implements ITextMessageService {
  final GeminiApi _api;

  TextMessageService(this._api);

  @override
  Future<IResponseResult<TextMessage>> generateAnswer(List<TextMessage> historical) async {
    try {
      final response = await _api.generateText(historical.toMap());
      return Success(NewTextMessageApiAdapter.fromMap(response));
    } catch (e) {
      return Fail('Não foi possível gerar a mensagem', e);
    }
  }
}
