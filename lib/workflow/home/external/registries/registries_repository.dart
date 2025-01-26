import 'package:plain_registry_app/core/response/i_response_result.dart';
import 'package:plain_registry_app/workflow/home/domain/i_repositories/i_registry_repository.dart';
import 'package:plain_registry_app/workflow/home/domain/models/registry_model.dart';
import 'package:sqflite/sqflite.dart';

part 'registries_adapter.dart';

class RegistriesRepository implements IRegistriesRepository {
  final Database _database;

  RegistriesRepository(this._database);

  @override
  Future<IResponseResult<List<RegistryModel>>> loadByGroup(String group) async {
    try {
      final response = await _database.query(
        'Registries',
        columns: [
          'id',
          'topic',
          'description',
          'content_group',
          'content_type',
          'date_time',
        ],
        where: 'content_group = ?',
        whereArgs: [group],
      );

      return Success(RegistriesAdapter.fromMapList(response));
    } catch (e) {
      return Fail('erro ao retornar registros', e);
    }
  }
}
