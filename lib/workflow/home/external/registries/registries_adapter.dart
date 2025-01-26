part of 'registries_repository.dart';

extension RegistriesAdapter on RegistryModel<dynamic>{
  static RegistryModel fromMap(Map<String, dynamic> map) => 
    RegistryModel(
      id: map['id'],
     contentName: map['content_name'],
     topic: map['topic'],
     description: map['description'],
     group: map['content_group'],
     dateTime: DateTime.parse(map['date_time']),
     contentData: map['content_data'], 
     contentType: RegistryType.fromString(map['content_type']));


  static List<RegistryModel> fromMapList(List<dynamic> list) =>
    list.map((e) => RegistriesAdapter.fromMap(e)).toList();
}