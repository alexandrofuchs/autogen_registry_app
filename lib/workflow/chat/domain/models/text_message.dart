import 'package:equatable/equatable.dart';

part 'enums/message_sender.dart';

class TextMessage extends Equatable {
  final int id;
  final MessageSender sender;
  final String text;

  const TextMessage({required this.id, required this.sender, required this.text});

  @override
  List<Object?> get props => [id, sender.value];

  Map<String, dynamic> toMap() => {
        'id': id,
        'role': sender.value,
        'text': text,
      };
}
