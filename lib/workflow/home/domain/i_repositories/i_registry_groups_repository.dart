import 'package:plain_registry_app/core/response/i_response_result.dart';


abstract class IRegistryGroupsRepository {
  Future<IResponseResult<List<String>>> load();
}