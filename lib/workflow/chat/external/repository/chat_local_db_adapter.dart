part of 'chat_repository.dart';

extension ChatLocalDbAdapter on Chat {
  Map<String, dynamic> toMap() =>
      {
        'content_data': jsonEncode(messages.map((e) => e.toMap()).toList()),
        'content_name': contentName,
        'content_type': contentType.value,
        'date_time': dateTime.toString(),
        'description': description,
        'content_group': group,
        'topic': topic,
      };

  static Chat fromMap(Map<String, dynamic> map, {int? id}) => Chat(
        id: id ?? map['id'],
        contentData: TextMessageLocalDbAdapter.fromMapList(
            jsonDecode(map['content_data'])),
        contentName: map['content_name'],
        contentType: RegistryType.fromString(map['content_type']),
        dateTime: DateTime.parse(map['date_time']),
        topic: map['topic'],
        description: map['description'],
        group: map['content_group'],
      );
}

extension TextMessageLocalDbAdapter on SavedTextMessageModel {
  Map<String, dynamic> toMap() => {
        'id': id,
        'reply_to_message_id': replyToMessageId,
        'role': sender.value,
        'text': text,
      };

  static SavedTextMessageModel fromMap(Map<String, dynamic> map) =>
      SavedTextMessageModel(
          id: map['id'],
          replyToMessageId: map['reply_to_message_id'],
          sender: MessageSender.fromValue(map['role']),
          text: map['text']);

  static List<SavedTextMessageModel> fromMapList(List<dynamic> list) =>
      list.map((e) => TextMessageLocalDbAdapter.fromMap(e)).toList();
}
