part of '../text_message.dart';

enum MessageSender {
  ia('model', 'Resposta gerada'),
  user('user', 'Seu texto');

  const MessageSender(this.value, this.label);

  final String value;
  final String label;

  factory MessageSender.fromValue(String value) =>
      MessageSender.values.firstWhere((e) => e.value == value);
}
