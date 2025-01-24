import 'package:plain_registry_app/workflow/chat/domain/models/text_message.dart';

class SavedTextMessageModel extends TextMessage {
  final int id;
  final int? replyToMessageId;

  const SavedTextMessageModel(
      {required this.id,
      required this.replyToMessageId,
      required super.sender,
      required super.text});

  @override
  List<Object?> get props => [id];

  @override
  Map<String, dynamic> toMap() => {
        'id': id,
        'reply_to_message_id': replyToMessageId,
        'role': sender.value,
        'text': text,
      };
}
