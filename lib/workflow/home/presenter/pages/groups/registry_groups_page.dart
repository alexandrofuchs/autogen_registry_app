import 'package:autogen_registry_app/workflow/home/presenter/widgets/new_registry_footer.dart';
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
    with CommonWidgets, NewRegistryFooter, RegistryGroupsWidgets {
  
  @override
  void initState() {
    context.read<RegistryGroupsProvider>().load();
    super.initState();
  }

  @override
  void dispose() {
    // context.read<RegistryGroupsProvider>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('REGISTRAI: Grupos'),
      ),
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: newRegistryFooter(context),
      body: Selector<RegistryGroupsProvider, RegistryGroupsProviderStatus>(
          selector: (context, provider) => provider.status,
          builder: (context, status, child) => switch (status) {
            RegistryGroupsProviderStatus.loading => const Center(
                child: CircularProgressIndicator(),
              ),
            RegistryGroupsProviderStatus.failed => Center(
                child: Text(
                  context.read<RegistryGroupsProvider>().errorMessage!,
                  style: AppTextStyles.labelStyleLarge,
                ),
              ),
            RegistryGroupsProviderStatus.loaded => Container(
                decoration:
                    const BoxDecoration(gradient: AppGradients.primaryColors),
                child: loadedGroups(context.read<RegistryGroupsProvider>()))
          },
        ),
      );
  }
}
