import 'dart:convert';

import 'package:plain_registry_app/core/response/i_response_result.dart';
import 'package:plain_registry_app/workflow/home/domain/i_repositories/i_registry_repository.dart';
import 'package:plain_registry_app/workflow/home/domain/models/registry_model.dart';
import 'package:sqflite/sqflite.dart';

part 'registries_adapter.dart';

class RegistriesRepository implements IRegistriesRepository {
  final Database _database;

  RegistriesRepository(this._database);

  @override
  Future<IResponseResult<int>> save(RegistryModel model) async {
    try {
      final response = await _database.insert('Registries', {});
      return Success(response);
    } catch (e) {
      return Fail('não foi possível salvar o registro', e);
    }
  }

  @override
  Future<IResponseResult<List<RegistryModel<String>>>> loadByGroup(
      String group) async {
    try {
      final response = [
        RegistryModel<String>(
            id: 1,
            topic: 'Um estudo',
            contentName: 'doc.pdf',
            description: 'Um arquivo pdf',
            contentData: '',
            group: 'estudos',
            dateTime: DateTime.now(),
            contentType: RegistryType.document)
      ];

      await Future.delayed(const Duration(seconds: 2));
      return Success(response);
    } catch (e) {
      return Fail('erro ao retornar registros', e);
    }
  }
}
