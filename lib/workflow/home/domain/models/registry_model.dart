import 'package:equatable/equatable.dart';
import 'package:plain_registry_app/core/helpers/extensions/list_extension.dart';

part 'registry_type.dart';

class RegistryModel<DataType extends dynamic> extends Equatable {
  final int? id;
  final String topic;
  final String description;
  final String group;
  final DateTime dateTime;
  final String? contentName;
  final RegistryType contentType;
  final DataType contentData;

  bool get hasId => id != null;

  const RegistryModel(
      {required this.id,
      required this.contentName,
      required this.topic,
      required this.description,
      required this.group,
      required this.dateTime,
      required this.contentData,
      required this.contentType});

  @override
  List<Object?> get props => [id];
}
