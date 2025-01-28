part of 'chat_repository.dart';

extension ChatLocalDbAdapter on Chat {
  Map<String, dynamic> toMap() =>
      {
        'id': id ?? DateTime.now().millisecondsSinceEpoch,
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

extension TextMessageLocalDbAdapter on TextMessage {
  Map<String, dynamic> toMap() => {
        'id': id,
        'role': sender.value,
        'text': text,
      };

  static TextMessage fromMap(Map<String, dynamic> map) =>
      TextMessage(
          id: map['id'],
          sender: MessageSender.fromValue(map['role']),
          text: map['text']);

  static List<TextMessage> fromMapList(List<dynamic> list) =>
      list.map((e) => TextMessageLocalDbAdapter.fromMap(e)).toList();
}
