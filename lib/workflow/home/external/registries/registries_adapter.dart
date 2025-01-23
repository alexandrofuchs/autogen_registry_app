part of 'registries_repository.dart';

extension RegistriesAdapter on RegistryModel<String>{
  Map<String, dynamic> toMap() => {
    'group': group,
    'date_time': dateTime,
    'description': description,
    'content_name':  filename,
    'content_type': type.value,
    'content_data': jsonEncode(data),
  };
}