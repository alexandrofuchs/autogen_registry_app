import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:autogen_registry_app/core/helpers/formatters/datetime_formatters.dart';
import 'package:autogen_registry_app/core/theme/app_colors.dart';
import 'package:autogen_registry_app/core/theme/app_gradients.dart';
import 'package:autogen_registry_app/core/theme/app_text_styles.dart';
import 'package:autogen_registry_app/core/widgets/appbar/appbar_widgets.dart';
import 'package:autogen_registry_app/core/widgets/searchbar/searchbar_widget.dart';
import 'package:autogen_registry_app/core/widgets/common/common_widgets.dart';
import 'package:autogen_registry_app/core/widgets/snackbars/app_snackbars.dart';
import 'package:autogen_registry_app/root/app_router.dart';
import 'package:autogen_registry_app/workflow/chat/chat_worflow.dart';
import 'package:autogen_registry_app/workflow/home/domain/models/registry_model.dart';
import 'package:autogen_registry_app/workflow/home/presenter/widgets/registries_widgets.dart';
import 'package:autogen_registry_app/workflow/home/presenter/pages/registries/registries_provider.dart';
import 'package:provider/provider.dart';

class OpenedRegistriesGroupPage extends StatefulWidget {
  final String group;
  const OpenedRegistriesGroupPage({super.key, required this.group});

  @override
  State<StatefulWidget> createState() => _OpenedRegistriesGroupPageState();
}

class _OpenedRegistriesGroupPageState extends State<OpenedRegistriesGroupPage>
    with SearchbarWidget, AppbarWidgets, CommonWidgets, RegistriesWidgets {

  
  @override
  initState(){
    context.read<RegistriesProvider>().loadByGroup(widget.group);
    super.initState();
  }

  Widget item(IconData icon, String title, String furtherInfo) => Container(
        margin: const EdgeInsets.all(15),
        decoration: const BoxDecoration(
            color: AppColors.primaryColorDark,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(25),
            ),
            border: Border(
              top: BorderSide(color: AppColors.primaryColorLight),
              bottom: BorderSide(color: AppColors.primaryColorLight))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(icon, color: AppColors.secundaryColor,),
                  const SizedBox(width: 15),
                  Text(
                    title,
                    softWrap: true,
                    style: AppTextStyles.labelStyleMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 15),
                  child: Text(
                    furtherInfo,
                    style: AppTextStyles.labelStyleSmall,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    AppSnackbars.showErrorSnackbar(context, 'ainda não implementado');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25)),
                        gradient: AppGradients.actionColors),
                    height: 45,
                    width: 100,
                    child: const Text(
                      'ações',
                      style: AppTextStyles.labelStyleSmall,
                      softWrap: true,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      );

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
                      searchBar((value) {
                        context.read<RegistriesProvider>().filterText = value;
                      }),
                      Expanded(
                          child: Container(
                        margin: const EdgeInsets.only(top: 25),
                        alignment: Alignment.topCenter,
                        decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                topRight: Radius.circular(25))),
                        child: Selector<RegistriesProvider, String>(
                          selector: (context, provider) => provider.filterText,
                          builder: (context, value, child) => ListView.builder(
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
                                RegistryType.textGeneration => Navigator.push(
                                    context,
                                    AppRouter.createRoute(ChatWorkflow.chatPage(
                                        context
                                            .read<RegistriesProvider>()
                                            .registries[index]))),
                              },
                              child: item(
                                      Icons.text_fields,
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
                      )),
                    ],
                  )
              }));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.group,
          style: AppTextStyles.labelStyleLarge,
          textAlign: TextAlign.center,
        ),
      ),
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: openedGroupWidget(),
    );
  }
}
