import 'package:autogen_registry_app/core/response/i_response_result.dart';
import 'package:autogen_registry_app/workflow/home/domain/models/registry_model.dart';

abstract class IRegistriesRepository {
  Future<IResponseResult<List<RegistryModel>>> loadByGroup(String group);
}
