import 'package:autogen_registry_app/workflow/chat/domain/models/text_message.dart';
import 'package:autogen_registry_app/workflow/home/domain/models/registry_model.dart';

class Chat extends RegistryModel<List<TextMessage>> {
  List<TextMessage> get messages => contentData;

  const Chat({
    required super.id,
    required super.topic,
    required super.contentName,
    required super.contentData,
    required super.contentType,
    required super.description,
    required super.group,
    required super.dateTime,
  });

  @override
  List<Object?> get props => [id, topic];

  Chat copyWith(List<TextMessage> messages) =>
    Chat(id: id, 
    topic: topic, 
    contentName: contentName, 
    contentData:  messages, 
    contentType: contentType, 
    description: description, 
    group: group, 
    dateTime: dateTime);
}
