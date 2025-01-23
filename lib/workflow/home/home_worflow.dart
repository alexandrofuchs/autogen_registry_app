import 'package:get_it/get_it.dart';
import 'package:plain_registry_app/core/services/app_cameras.dart';
import 'package:plain_registry_app/data/local_database/app_local_db.dart';
import 'package:plain_registry_app/workflow/home/domain/i_repositories/i_registry_groups_repository.dart';
import 'package:plain_registry_app/workflow/home/domain/i_repositories/i_registry_repository.dart';
import 'package:plain_registry_app/workflow/home/external/groups/registry_groups_repository.dart';
import 'package:plain_registry_app/workflow/home/external/registries/registries_repository.dart';
import 'package:sqflite/sqflite.dart';

abstract class HomeWorflow {
  static void register() {
    GetIt.I.registerSingleton<AppCameras>(AppCameras.instance);
    GetIt.I.registerSingleton<Database>(AppLocalDb.instance.localDatabase);
    GetIt.I.registerSingleton<IRegistryGroupsRepository>(RegistryGroupsRepository(GetIt.I.get()));
    GetIt.I.registerSingleton<IRegistriesRepository>(RegistriesRepository(GetIt.I.get()));
  }
}
