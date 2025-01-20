import 'package:flutter/material.dart';
import 'package:plain_registry_app/core/response/i_response_result.dart';
import 'package:plain_registry_app/workflow/home/domain/i_repositories/i_registry_repository.dart';
import 'package:plain_registry_app/workflow/home/domain/models/registry_model.dart';

class RegistriesRepository implements IRegistriesRepository {
  @override
  Future<IResponseResult<List<CategoryModel<RegistryModel>>>> load() async {
    try {
      final categories = [
        CategoryModel('estudos', [
          RegistryModel(
              filename: 'doc.pdf',
              description: 'Um arquivo pdf',
              category: 'estudos',
              dateTime: DateTime.now(),
              type: RegistryType.document),
        ]),
        CategoryModel('treinos', [
          RegistryModel(
              filename: 'image.png',
              description: 'Um arquivo de imagem',
              category: 'treinos',
              dateTime: DateTime.now(),
              type: RegistryType.image),
          RegistryModel(
              filename: 'video.mp4',
              description: 'Um arquivo de video',
              category: 'treinos',
              dateTime: DateTime.now(),
              type: RegistryType.video),
        ])
      ];

      await Future.delayed(const Duration(seconds: 2));
      return Success(categories);
    } catch (e) {
      debugPrint(e.toString());
      return Fail('erro ao retornar registros');
    }
  }
}
