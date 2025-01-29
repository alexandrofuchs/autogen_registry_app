import 'package:flutter/material.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_gradients.dart';
import 'package:plain_registry_app/core/theme/app_text_styles.dart';
import 'package:plain_registry_app/core/widgets/appbar/appbar_widgets.dart';
import 'package:plain_registry_app/core/widgets/searchbar/searchbar_widget.dart';
import 'package:plain_registry_app/core/widgets/common/common_widgets.dart';
import 'package:plain_registry_app/root/app_router.dart';
import 'package:plain_registry_app/workflow/home/home_worflow.dart';
import 'package:plain_registry_app/workflow/home/presenter/widgets/registries_widgets.dart';
import 'package:plain_registry_app/workflow/home/presenter/pages/groups/registry_groups_provider.dart';
import 'package:provider/provider.dart';

class RegistryGroupsPage extends StatefulWidget {
  const RegistryGroupsPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegistryGroupsPageState();
}

class _RegistryGroupsPageState extends State<RegistryGroupsPage>
    with SearchbarWidget, AppbarWidgets, CommonWidgets, RegistriesWidgets {
  @override
  void initState() {
    context.read<RegistryGroupsProvider>().load();
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
  }

  Widget groupWidget(RegistryGroupsProvider provider, int groupIndex) =>
      GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              AppRouter.createRoute(
                  HomeWorflow.openedRegistryGroupPage(
                      provider.groups[groupIndex]),
                  transition: RouteTransition.rightToLeft));
        },
        child: Container(
            margin: const EdgeInsets.only(top: 15, left: 5, right: 5),
            decoration: const BoxDecoration(
              color: AppColors.primaryColorDark,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  topLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5),
                  topRight: Radius.circular(25)),
              border: Border(
                  top: BorderSide(color: AppColors.backgroundColor),
                  bottom: BorderSide(color: AppColors.backgroundColor)),
            ),
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: [
                Expanded(child: titleDot(provider.groups[groupIndex])),
                const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: AppColors.secundaryColor,
                  ),
                ),
              ],
            )),
      );

  Widget loadedGroups(RegistryGroupsProvider provider) => Container(
        margin: const EdgeInsets.only(top: 15),
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(15),
        child: provider.groups.isEmpty
            ? Center(
                child: Container(
                  decoration: const ShapeDecoration(shape: RoundedRectangleBorder(
                    side: BorderSide(color: AppColors.primaryColorLight, width: 3),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(5),topRight: Radius.circular(5),
                      topLeft: Radius.circular(25), bottomRight: Radius.circular(25))
                  ),
                  color: AppColors.primaryColorDark),
                  padding: const EdgeInsets.all(15),
                  child: const Text(
                    'Nenhum grupo criado',
                    style: AppTextStyles.labelStyleLarge
                  ),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                itemCount: provider.groups.length,
                itemBuilder: (context, groupIndex) =>
                    groupWidget(provider, groupIndex),
              ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('GRUPOS DE REGISTRO'),
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
