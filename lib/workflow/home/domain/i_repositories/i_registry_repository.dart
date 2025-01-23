import 'package:plain_registry_app/core/response/i_response_result.dart';
import 'package:plain_registry_app/workflow/home/domain/models/registry_model.dart';

abstract class IRegistriesRepository {
  Future<IResponseResult<int>> save(RegistryModel model);
  Future<IResponseResult<List<RegistryModel<String>>>> loadByGroup(String group);
}
