import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:plain_registry_app/core/helpers/formatters/datetime_formatters.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_gradients.dart';
import 'package:plain_registry_app/core/theme/app_text_styles.dart';
import 'package:plain_registry_app/core/widgets/appbar/appbar_widgets.dart';
import 'package:plain_registry_app/core/widgets/searchbar/searchbar_widget.dart';
import 'package:plain_registry_app/core/widgets/common/common_widgets.dart';
import 'package:plain_registry_app/root/app_router.dart';
import 'package:plain_registry_app/workflow/chat/chat_worflow.dart';
import 'package:plain_registry_app/workflow/home/domain/models/registry_model.dart';
import 'package:plain_registry_app/workflow/home/presenter/widgets/registries_widgets.dart';
import 'package:plain_registry_app/workflow/home/presenter/pages/registries/registries_provider.dart';
import 'package:provider/provider.dart';

class OpenedRegistriesGroupPage extends StatelessWidget
    with SearchbarWidget, AppbarWidgets, CommonWidgets, RegistriesWidgets {
  final String group;
  OpenedRegistriesGroupPage({super.key, required this.group});

  final fileIcons = <IconData>[
    Icons.picture_as_pdf,
    Icons.image,
    Icons.video_file_rounded,
  ];

  Widget openedGroupWidget() => Container(
      decoration: const BoxDecoration(gradient: AppGradients.primaryColors),
      child: Selector<RegistriesProvider, RegistriesProviderStatus>(
          selector: (context, provider) => provider.status,
          builder: (context, status, child) => switch (status) {
                RegistriesProviderStatus.loading => const Center(
                    child: CircularProgressIndicator(),
                  ),
                RegistriesProviderStatus.failed => const Center(
                    child: Text('Não foi possível carregar os items'),
                  ),
                RegistriesProviderStatus.loaded => Column(
                    children: [
                      Container(
                          alignment: Alignment.bottomCenter,
                          height: 50,
                          margin: const EdgeInsets.only(top: 5, bottom: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              BackButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                color: AppColors.primaryColor,
                                style: const ButtonStyle(
                                  iconSize: WidgetStatePropertyAll(24),
                                ),
                              ),
                              Expanded(
                                child: Text(
                                  context
                                      .read<RegistriesProvider>()
                                      .registries
                                      .first
                                      .group,
                                  style: AppTextStyles.labelStyleLarge,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )),
                      searchBar((value) {
                        // context.read<RegistryGroupsProvider>().textFilter = value;
                      }),
                      filterBar(),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(top: 0),
                          alignment: Alignment.topCenter,
                          decoration: const BoxDecoration(
                              color: AppColors.backgroundColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25),
                                  topRight: Radius.circular(25))),
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: context
                                .read<RegistriesProvider>()
                                .registries
                                .length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () => switch (context
                                  .read<RegistriesProvider>()
                                  .registries[index]
                                  .contentType) {
                                RegistryType.document => null,
                                RegistryType.video => null,
                                RegistryType.image => null,
                                RegistryType.audio => null,
                                RegistryType.textGeneration => Navigator.push(
                                    context,
                                    AppRouter.createRoute(ChatWorkflow.page(
                                        context
                                            .read<RegistriesProvider>()
                                            .registries[index]))),
                              },
                              child: item(
                                      fileIcons[index],
                                      context
                                          .read<RegistriesProvider>()
                                          .registries[index]
                                          .description,
                                      '${context.read<RegistriesProvider>().registries[index].group} | ${context.read<RegistriesProvider>().registries[index].dateTime.toDaysNumberPast()}')
                                  .animate()
                                  .moveX(
                                      begin: -1000,
                                      end: 0,
                                      delay:
                                          Duration(milliseconds: 500 * index)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
              }));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: AppColors.primaryColor,
      ),
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: newRegistryFooter(context),
      body: openedGroupWidget(),
    );
  }
}
