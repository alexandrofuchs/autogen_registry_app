part of 'registry_model.dart';

enum RegistryType {
  textGeneration("text", [], "texto gerado");

  const RegistryType(this.value, this.contentTypes, this.label);

  final String value;
  final Iterable<String> contentTypes;
  final String label;

  static RegistryType fromString(String value) =>
      RegistryType.values.firstWhere((e) => e.value == value);

  static RegistryType? fromStringOrNull(String value) =>
      RegistryType.values.firstWhereOrNull((e) => e.value == value);
  
  @override
  String toString(){
    return label; 
  }
}
