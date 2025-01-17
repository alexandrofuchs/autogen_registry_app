import 'package:plain_registry_app/workflow/home/domain/models/registry_model.dart';

abstract class IRegistryRepository<DataType extends RegistryModel> {
  Future<void> save();
  Future<void> load();
}
