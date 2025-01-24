part of 'text_message_service.dart';

extension NewTextMessageApiAdapter on NewTextMessageModel {
  static TextMessage fromMap(Map<String, dynamic> map) => NewTextMessageModel(
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
            })
      };
}
