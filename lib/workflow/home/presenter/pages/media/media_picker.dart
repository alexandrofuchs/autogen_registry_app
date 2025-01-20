import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:plain_registry_app/core/helpers/converters/file_converter.dart';
import 'package:plain_registry_app/core/widgets/snackbars/app_snackbars.dart';
import 'package:plain_registry_app/workflow/home/domain/models/loaded_file.dart';

mixin MediaPicker {
  final ImagePicker picker = ImagePicker();

  final _bytesToMegaBytesConverter = 1048576;

  bool _checkMaxLength(BuildContext context,
      {required int lengthInBytes, int maxMegaByteLength = 50}) {
    final totalLengthInMbytes = (lengthInBytes) / _bytesToMegaBytesConverter;
    final isExceeded = totalLengthInMbytes > maxMegaByteLength;

    if (isExceeded) {
      AppSnackbars.showErrorSnackbar(context, 'Arquivo excede o tamanho limite(max: 50mb).');
    }
    return isExceeded;
  }

  Future<File?> _prepareFile(BuildContext context, XFile? res) async {
    if (res == null) return null;
    final length = await res.length();
    if (context.mounted && _checkMaxLength(context, lengthInBytes: length)) return null;
    if (context.mounted) return FileConverter.xFileToFile(res);
    return null;
  }

  Future<LoadedFile?> pickMedia(BuildContext context) async {
    final XFile? res = await picker.pickMedia();
    if (!context.mounted) return null;
    final file = await _prepareFile(context, res);
    if(file == null) return null;
    String? mimeStr = lookupMimeType(file.path);
    if(mimeStr == null) return null;
    debugPrint('file type $mimeStr');
    final fileType = MediaType.fromStringOrNull(mimeStr);
    if(fileType == null) return null;
    final mediaFile = LoadedFile(file, fileType);
    debugPrint('file type ${mediaFile.mediaType.label}');
    return mediaFile;
  }


  Future<File?> pickImage(BuildContext context, ImageSource source) async {
    final XFile? res = await picker.pickImage(source: source);
    if (!context.mounted) return null;
    return _prepareFile(context, res);
  }

  Future<File?> pickVideo(BuildContext context, ImageSource source) async {
    final XFile? res = await picker.pickVideo(
        source: source, maxDuration: const Duration(seconds: 15));
    if (!context.mounted) return null;
    return _prepareFile(context, res);
  }
}
