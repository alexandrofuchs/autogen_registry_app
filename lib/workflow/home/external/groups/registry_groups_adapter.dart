part of 'registry_groups_repository.dart';

extension RegistryGroupsAdapter on String {
  static String fromMap(Map<String, dynamic> map) => map['group'];

  static List<String> fromMapList(List<dynamic> list) =>
      list.map((e) => RegistryGroupsAdapter.fromMap(e)).toList();
}
