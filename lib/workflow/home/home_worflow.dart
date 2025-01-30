import 'package:autogen_registry_app/workflow/chat/presenter/chat_page.dart';
import 'package:autogen_registry_app/workflow/chat/presenter/chat_provider.dart';
import 'package:autogen_registry_app/workflow/home/domain/models/registry_model.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:autogen_registry_app/core/services/app_cameras.dart';
import 'package:autogen_registry_app/data/local_database/app_local_db.dart';
import 'package:autogen_registry_app/workflow/home/domain/i_repositories/i_registry_groups_repository.dart';
import 'package:autogen_registry_app/workflow/home/domain/i_repositories/i_registry_repository.dart';
import 'package:autogen_registry_app/workflow/home/external/groups/registry_groups_repository.dart';
import 'package:autogen_registry_app/workflow/home/external/registries/registries_repository.dart';
import 'package:autogen_registry_app/workflow/home/presenter/pages/groups/registry_groups_page.dart';
import 'package:autogen_registry_app/workflow/home/presenter/pages/groups/registry_groups_provider.dart';
import 'package:autogen_registry_app/workflow/home/presenter/pages/registries/opened_registries_group_page.dart';
import 'package:autogen_registry_app/workflow/home/presenter/pages/registries/registries_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

abstract class HomeWorflow {
  static void register() {
    GetIt.I.registerSingleton<AppCameras>(AppCameras.instance);
    GetIt.I.registerSingleton<Database>(AppLocalDb.instance.localDatabase);
    GetIt.I.registerSingleton<IRegistryGroupsRepository>(RegistryGroupsRepository(GetIt.I.get()));
    GetIt.I.registerSingleton<IRegistriesRepository>(RegistriesRepository(GetIt.I.get()));
  }

  static Widget openedRegistryGroupPage(String param) =>
      ChangeNotifierProvider<RegistriesProvider>(
        create: (context) => RegistriesProvider(GetIt.I.get()),
        builder: (context, child) => child ?? const Center(child: CircularProgressIndicator(),),
        child: OpenedRegistriesGroupPage(group: param),
      );

  static Widget groupsPage() => ChangeNotifierProvider<RegistryGroupsProvider>(
        create: (context) => RegistryGroupsProvider(GetIt.I.get()),
        builder: (context, child) => child ?? 
          const Center(child: CircularProgressIndicator(),),
        lazy: true,
        child: const RegistryGroupsPage(),
      );

  static Widget newRegistryPage(RegistryModel registry) =>
      ChangeNotifierProvider(
        create: (context) => ChatProvider(GetIt.I.get()),
        child: ChatPage(registry: registry),
      );
}
