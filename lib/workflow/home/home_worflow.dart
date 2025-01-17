import 'package:get_it/get_it.dart';
import 'package:plain_registry_app/workflow/home/domain/i_repositories/i_registry_repository.dart';
import 'package:plain_registry_app/workflow/home/external/registry_repository.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerLazySingleton<IRegistryRepository>(
    () => RegistryRepository(),
  );
}
