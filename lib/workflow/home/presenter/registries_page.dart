import 'package:flutter/material.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_gradients.dart';
import 'package:plain_registry_app/core/widgets/appbar/appbar_widgets.dart';
import 'package:plain_registry_app/core/widgets/searchbar/searchbar_widget.dart';
import 'package:plain_registry_app/core/widgets/common/common_widgets.dart';
import 'package:plain_registry_app/workflow/home/presenter/pages/new_registry_page.dart';
import 'package:plain_registry_app/workflow/home/presenter/providers/registry_groups_provider.dart';
import 'package:plain_registry_app/root/app_router.dart';
import 'package:provider/provider.dart';

class RegistriesPage extends StatefulWidget {
  const RegistriesPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegistriesPageState();
}

class _RegistriesPageState extends State<RegistriesPage>
    with SearchbarWidget, AppbarWidgets, CommonWidgets {
  final ValueNotifier<int?> focusedGroupIndex = ValueNotifier(null);

  @override
  void initState() {
    context.read<RegistryGroupsProvider>().load();
    super.initState();
  }

  final fileIcons = <IconData>[
    Icons.picture_as_pdf,
    Icons.image,
    Icons.video_file_rounded,
  ];

  @override
  dispose() {
    super.dispose();
  }

  Widget footer() => GestureDetector(
        onTap: () {
          Navigator.of(context).push(AppRouter.createRoute(
              ChangeNotifierProvider<RegistryGroupsProvider>.value(
                  value: context.read<RegistryGroupsProvider>(),
                  child: const NewRegistryPage())));
        },
        child: titleContainer('Adicionar novo arquivo'),
      );

  Widget openedGroupWidget(RegistryGroupsProvider provider, int? groupIndex) =>
      const SizedBox();

  Widget closedGroupWidget(RegistryGroupsProvider provider, int groupIndex) =>
      GestureDetector(
        onTap: () {
          focusedGroupIndex.value = groupIndex;
        },
        child: Container(
            margin: const EdgeInsets.only(top: 15),
            decoration: const BoxDecoration(
                gradient: AppGradients.primaryColors,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    topLeft: Radius.circular(100),
                    bottomRight: Radius.circular(100),
                    topRight: Radius.circular(25)),
                boxShadow: [BoxShadow(offset: Offset(0, 1))]),
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

  Widget _groupList(RegistryGroupsProvider provider) => Column(
        children: [
          pageHeader('Grupos'),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(top: 15),
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 0,
                      spreadRadius: 1,
                      offset: Offset(0, -1),
                      color: AppColors.primaryColorDark,
                    )
                  ],
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(25)),
              padding: const EdgeInsets.all(15),
              child: 
              provider.groups.isEmpty ?
                const Center(child: Text('Nenhum grupo criado'),) :
              ListView.builder(
                shrinkWrap: true,
                itemCount: provider.groups.length,
                itemBuilder: (context, groupIndex) =>
                    closedGroupWidget(provider, groupIndex),
              ),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColors.primaryColor,
      ),
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: footer(),
      body: Selector<RegistryGroupsProvider, RegistryGroupsProviderStatus>(
        
        selector: (context, provider) => provider.status,
        builder: (context, status, child) => switch (status) {
          RegistryGroupsProviderStatus.loading => const Center(
              child: CircularProgressIndicator(),
            ),
          RegistryGroupsProviderStatus.failed => Center(
              child: Text(context.read<RegistryGroupsProvider>().errorMessage!),
            ),
          RegistryGroupsProviderStatus.loaded => Container(
              decoration:
                  const BoxDecoration(gradient: AppGradients.primaryColors),
              child: ValueListenableBuilder(
                  valueListenable: focusedGroupIndex,
                  builder: (context, value, child) => AnimatedCrossFade(
                      layoutBuilder:
                          (topChild, topChildKey, bottomChild, bottomChildKey) {
                        return Stack(
                          fit: StackFit.expand,
                          alignment: Alignment.center,
                          children: <Widget>[
                            Positioned(
                              key: bottomChildKey,
                              child: bottomChild,
                            ),
                            Positioned(
                              key: topChildKey,
                              child: topChild,
                            ),
                          ],
                        );
                      },
                      alignment: Alignment.topCenter,
                      firstChild: _groupList(context.read<RegistryGroupsProvider>()),
                      secondChild: openedGroupWidget(context.read<RegistryGroupsProvider>(), focusedGroupIndex.value),
                      crossFadeState: focusedGroupIndex.value != null
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 500))))
        },
      ),
    );
  }
}
