import 'package:equatable/equatable.dart';
import 'package:plain_registry_app/core/helpers/extensions/list_extension.dart';

part 'registry_type.dart';

class CategoryModel<DataType extends Object> extends Equatable {
  final String name;
  final List<DataType> items;

  const CategoryModel(this.name, this.items);

  @override
  List<Object?> get props => [name];
}

class RegistryModel extends Equatable {
  final String filename;
  final String description;
  final String category;
  final DateTime dateTime;
  final RegistryType type;

  const RegistryModel(
      {required this.filename,
      required this.description,
      required this.category,
      required this.dateTime,
      required this.type});

  @override
  List<Object?> get props => [
        filename,
        description,
        category,
        dateTime,
        type,
      ];
}
