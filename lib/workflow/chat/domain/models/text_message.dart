import 'package:equatable/equatable.dart';

part 'enums/message_sender.dart';

abstract class TextMessage extends Equatable {
  final MessageSender sender;
  final String text;

  const TextMessage({required this.sender, required this.text});

  @override
  List<Object?> get props => [text, sender.value];

  Map<String, dynamic> toMap();
}
