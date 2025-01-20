import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:plain_registry_app/core/helpers/extensions/list_extension.dart';

enum MediaType {
  image('image', 'Foto'),
  video('video', 'Video');

  const MediaType(this.contentType, this.label);

  final String contentType;
  final String label;

  static MediaType fromString(String value) =>
      MediaType.values.firstWhere((e) => value.contains(e.contentType));

  static MediaType? fromStringOrNull(String value) =>
      MediaType.values.firstWhereOrNull((e) => value.contains(e.contentType));
}

class LoadedFile extends Equatable {
  final File file;
  final MediaType mediaType;

  const LoadedFile(this.file, this.mediaType);

  @override
  List<Object?> get props => [file, mediaType];
}
