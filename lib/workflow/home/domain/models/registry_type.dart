part of 'registry_model.dart';

enum RegistryType {
  document("document", ['application/pdf']),
  video("video", ['video/mp4']),
  image("image", ['image/jpeg', 'image/png', 'image/gif']),
  audio("audio", ['audio/mp3, audio/wav']),
  text("text", []);

  const RegistryType(this.value, this.contentTypes);

  final String value;
  final Iterable<String> contentTypes;

  static RegistryType fromString(String value) =>
      RegistryType.values.firstWhere((e) => e.value == value);

  static RegistryType? fromStringOrNull(String value) =>
      RegistryType.values.firstWhereOrNull((e) => e.value == value);
  
  @override
  String toString(){
    return value; 
  }
}
