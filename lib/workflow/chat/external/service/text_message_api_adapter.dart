part of 'text_message_service.dart';

extension NewTextMessageApiAdapter on TextMessage {
  static TextMessage fromMap(Map<String, dynamic> map) => TextMessage(
      id: DateTime.now().millisecondsSinceEpoch,
      sender: MessageSender.fromValue(map['candidates'][0]['content']['role']),
      text: map['candidates'][0]['content']['parts'][0]['text']);

  static List<TextMessage> fromMapList(List<dynamic> list) =>
      list.map((e) => NewTextMessageApiAdapter.fromMap(e['content'])).toList();
}

extension MessagesApiAdapter on List<TextMessage> {
  Map<String, dynamic> toMap() => {
        'contents': map((e) => {
              "role": e.sender.value,
              "parts": [
                {
                  "text": e.text,
                }
              ]
            }).toList()
      };
}
