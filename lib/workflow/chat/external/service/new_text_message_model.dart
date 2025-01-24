import 'package:plain_registry_app/workflow/chat/domain/models/text_message.dart';

class NewTextMessageModel extends TextMessage {
  const NewTextMessageModel({required super.sender, required super.text});

  @override
  List<Object?> get props => [text, sender.value];
  
  @override
  Map<String, dynamic> toMap() => {
      'text': text,
      'role': sender.value,
  };
}
