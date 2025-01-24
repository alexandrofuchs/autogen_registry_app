part of 'registries_repository.dart';

extension RegistriesAdapter on RegistryModel<String>{
  Map<String, dynamic> toMap() => {
    'group': group,
    'date_time': dateTime,
    'description': description,
    'content_name':  contentName,
    'content_type': contentType.value,
    'content_data': jsonEncode(contentData),
  };
}