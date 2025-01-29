import 'package:flutter/material.dart';
import 'package:autogen_registry_app/core/widgets/common/common_widgets.dart';
import 'package:autogen_registry_app/root/app_router.dart';
import 'package:autogen_registry_app/workflow/home/presenter/pages/new_registry/new_registry_page.dart';
import 'package:autogen_registry_app/workflow/home/presenter/pages/groups/registry_groups_provider.dart';
import 'package:provider/provider.dart';

mixin RegistriesWidgets on CommonWidgets {
  Widget newRegistryFooter(BuildContext context) => GestureDetector(
        onTap: () {
          Navigator.of(context).push(AppRouter.createRoute(
              ChangeNotifierProvider<RegistryGroupsProvider>.value(
                  value: context.read<RegistryGroupsProvider>(),
                  child: const NewRegistryPage()), transition: RouteTransition.downToUp),);
        },
        child: titleContainer('Adicionar novo arquivo'),
      );
}
