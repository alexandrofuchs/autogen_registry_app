import 'package:equatable/equatable.dart';
import 'package:plain_registry_app/core/helpers/extensions/list_extension.dart';

part 'registry_type.dart';

class RegistryModel<DataType extends Object> extends Equatable {
  final int id;
  final String filename;
  final String description;
  final String group;
  final DateTime dateTime;
  final RegistryType type;
  final DataType data;

  const RegistryModel(
      {required this.id,
      required this.filename,
      required this.description,
      required this.group,
      required this.dateTime,
      required this.data,
      required this.type});

  @override
  List<Object?> get props => [id];
}
