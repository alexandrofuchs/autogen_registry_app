import 'package:flutter/material.dart';
import 'package:autogen_registry_app/core/theme/app_colors.dart';
import 'package:autogen_registry_app/core/theme/app_gradients.dart';
import 'package:autogen_registry_app/core/theme/app_text_styles.dart';
import 'package:autogen_registry_app/core/widgets/common/common_widgets.dart';
import 'package:autogen_registry_app/root/app_router.dart';
import 'package:autogen_registry_app/workflow/home/home_worflow.dart';
import 'package:autogen_registry_app/workflow/home/presenter/pages/groups/registry_groups_provider.dart';
import 'package:provider/provider.dart';

part 'registry_groups_widgets.dart';

class RegistryGroupsPage extends StatefulWidget {
  const RegistryGroupsPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegistryGroupsPageState();
}

class _RegistryGroupsPageState extends State<RegistryGroupsPage>
    with CommonWidgets, RegistryGroupsWidgets {
  @override
  void initState() {
    super.initState();

    context.read<RegistryGroupsProvider>().load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget loading() => const Center(child: CircularProgressIndicator());

  Widget failed() => Center(
        child: Text(
          context.read<RegistryGroupsProvider>().errorMessage!,
          style: AppTextStyles.labelStyleLarge,
        ),
      );

  Widget loaded() => Container(
      margin: const EdgeInsets.only(bottom: 60),
      decoration: const BoxDecoration(gradient: AppGradients.primaryColors),
      child: loadedGroups(context.read<RegistryGroupsProvider>()));

  Widget newRegistryFooter() => GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          AppRouter.route(
              HomeWorflow.newRegistryPage(
                  groups: context.read<RegistryGroupsProvider>().groups),
              transition: RouteTransition.downToUp),
        );
      },
      child: titleContainer('Novo Registro'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('RegistrAI'),
      ),
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: newRegistryFooter(),
      body: Selector<RegistryGroupsProvider, RegistryGroupsProviderStatus>(
        selector: (context, provider) => provider.status,
        shouldRebuild: (previous, next) => previous != next,
        builder: (context, status, child) => switch (status) {
          RegistryGroupsProviderStatus.loading => loading(),
          RegistryGroupsProviderStatus.failed => failed(),
          RegistryGroupsProviderStatus.loaded => loaded(),
        },
      ),
    );
  }
}
