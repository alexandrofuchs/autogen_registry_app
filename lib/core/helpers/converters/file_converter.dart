import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

enum FileExtension {
  jpg('.jpg'),
  png('.png'),
  mp4('.mp4'),
  pdf('.pdf');

  const FileExtension(this.value);

  final String value;
}

abstract class FileConverter {
  static File? xFileToFile(XFile file) {
    try {
      return File(file.path);
    } catch (e) {
      debugPrint('xFileToFile: failed to convert --> $e');
      return null;
    }
  }

  static Future<File?> bytesToFile(
      {required String name,
      required FileExtension extension,
      required Uint8List bytes}) async {
    try {
      final directory = await getTemporaryDirectory();
      name = name;
      var file = File("${directory.path}/$name${extension.value}");
      await file.writeAsBytes(bytes);
      return file;
    } catch (e) {
      debugPrint('bytesToFile: failed to convert --> $e');
      return null;
    }
  }

  static Uint8List? fileToBytes(File? file) {
    try {
      if (file == null) {
        return null;
      }
      return File(file.path).readAsBytesSync();
    } catch (e) {
      debugPrint('fileToBytes: failed to convert --> $e');
      return null;
    }
  }

  static String? fileToBase64(File? file) {
    try {
      if (file == null) {
        return null;
      }
      return base64Encode(fileToBytes(file)!);
    } catch (e) {
      debugPrint('fileToBase64: failed to convert --> $e');
      return null;
    }
  }

  static Future<bool> exportFromBase64(
      {required String directoryName,
      required String fileName,
      required String base64}) async {
    try {
      const basePath = '/storage/emulated/0/Download';
      final targetDir = Directory('$basePath/$directoryName');
      if (!await targetDir.exists()) {
        await targetDir.create(recursive: true);
      }
      final file = File('${targetDir.path}/$fileName');
      await file.writeAsBytes(base64Decode(base64));
      debugPrint('File saved to: ${file.path}');
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<bool> exportFromBytes(
      {required String directoryName,
      required String fileName,
      required Uint8List bytes}) async {
    try {
      const basePath = '/storage/emulated/0/Download';
      final targetDir = Directory('$basePath/$directoryName');
      if (!await targetDir.exists()) {
        await targetDir.create(recursive: true);
      }
      final file = File('${targetDir.path}/$fileName');
      await file.writeAsBytes(bytes);
      debugPrint('File saved to: ${file.path}');
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
