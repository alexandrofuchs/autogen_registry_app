part of '../text_message.dart';

enum MessageSender {
  ia('model'),
  user('user');

  const MessageSender(this.value);

  final String value;

  factory MessageSender.fromValue(String value) =>
      MessageSender.values.firstWhere((e) => e.value == value);
}
