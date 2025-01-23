import 'package:plain_registry_app/core/response/i_response_result.dart';
import 'package:plain_registry_app/workflow/home/domain/i_repositories/i_registry_groups_repository.dart';
import 'package:sqflite/sqflite.dart';

part 'registry_groups_adapter.dart';

class RegistryGroupsRepository  implements IRegistryGroupsRepository{
  final Database _database;

  RegistryGroupsRepository(this._database);
  
  @override
  Future<IResponseResult<List<String>>> load() async {
    try{
      final response = await _database.query('Registries', columns: ['content_group']);
      return Success(RegistryGroupsAdapter.fromMapList(response));
    }catch(e){
      return Fail('não foi possivel carregar os grupos', e);
    }
  }

}