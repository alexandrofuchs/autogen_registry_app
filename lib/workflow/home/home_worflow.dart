import 'package:get_it/get_it.dart';
import 'package:plain_registry_app/workflow/home/domain/i_repositories/i_registry_repository.dart';
import 'package:plain_registry_app/workflow/home/external/registries_repository.dart';

abstract class HomeWorflow {
  static void register() {
    GetIt.I.registerSingleton<IRegistriesRepository>(RegistriesRepository());
  }
}
