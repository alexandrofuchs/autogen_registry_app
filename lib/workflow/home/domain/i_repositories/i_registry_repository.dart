import 'package:plain_registry_app/core/response/i_response_result.dart';
import 'package:plain_registry_app/workflow/home/domain/models/registry_model.dart';

abstract class IRegistriesRepository {
  Future<IResponseResult<List<CategoryModel<RegistryModel>>>> load();
}
