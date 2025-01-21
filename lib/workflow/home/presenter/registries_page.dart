import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:plain_registry_app/core/helpers/formatters/datetime_formatters.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_gradients.dart';
import 'package:plain_registry_app/core/theme/app_text_styles.dart';
import 'package:plain_registry_app/core/widgets/appbar/appbar_widgets.dart';
import 'package:plain_registry_app/core/widgets/searchbar/searchbar_widget.dart';
import 'package:plain_registry_app/core/widgets/common/common_widgets.dart';
import 'package:plain_registry_app/workflow/home/presenter/pages/new_registry_page.dart';
import 'package:plain_registry_app/workflow/home/presenter/providers/registries_provider.dart';
import 'package:plain_registry_app/workflow/root/app_router.dart';
import 'package:provider/provider.dart';

class RegistriesPage extends StatefulWidget {
  const RegistriesPage({super.key});

  @override
  State<StatefulWidget> createState() => _RegistriesPageState();
}

class _RegistriesPageState extends State<RegistriesPage>
    with SearchbarWidget, AppbarWidgets, CommonWidgets {
  final ValueNotifier<int?> focusedCategoryIndex = ValueNotifier(null);

  @override
  void initState() {
    context.read<RegistriesProvider>().load();
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
              ChangeNotifierProvider<RegistriesProvider>.value(
                  value: context.read<RegistriesProvider>(),
                  child: const NewRegistryPage())));
        },
        child: headerContainer('Adicionar novo arquivo'),
      );

  Widget openedCategoryWidget(
          RegistriesProvider provider, int? categoryIndex) =>
      categoryIndex != null
          ? Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(children: [
                  Row(
                    children: [
                      BackButton(
                        onPressed: () {
                          focusedCategoryIndex.value = null;
                        },
                        color: AppColors.secundaryColor,
                        style: const ButtonStyle(
                          iconSize: WidgetStatePropertyAll(24),
                        ),
                      ),
                      Text(
                        provider.categories![categoryIndex].name,
                        style: AppTextStyles.labelStyleLarge,
                      ),
                    ],
                  ),
                  searchBar((value) {}),
                  filterBar()
                ]),
                Container(
                  margin: const EdgeInsets.only(top: 160),
                  alignment: Alignment.topCenter,
                  decoration: const BoxDecoration(
                      color: AppColors.backgroundColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25))),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: provider.categories![categoryIndex].items.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => item(
                            fileIcons[index],
                            provider.categories![categoryIndex].items[index]
                                .description,
                            '${provider.categories![categoryIndex].items[index].category} | ${provider.categories![categoryIndex].items[index].dateTime.toDaysNumberPast()}')
                        .animate()
                        .moveX(
                            begin: -1000,
                            end: 0,
                            delay: Duration(milliseconds: 500 * index)),
                  ),
                ),
              ],
            )
          : const SizedBox();

  Widget closedCategoryWidget(RegistriesProvider provider, int categoryIndex) =>
      GestureDetector(
        onTap: () {
          focusedCategoryIndex.value = categoryIndex;
        },
        child: Container(
            margin: const EdgeInsets.only(top: 15),
            decoration: const BoxDecoration(
                color: AppColors.secundaryColor,
                boxShadow: [
                  BoxShadow(
                      color: AppColors.primaryColorDark,
                      spreadRadius: 1,
                      blurRadius: 1)
                ]),
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              children: [
                Expanded(
                    child: titleDot(provider.categories![categoryIndex].name)),
                const Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 12,
                    color: AppColors.primaryColorDark,
                  ),
                ),
              ],
            )),
      );

  Widget _categoriesList(RegistriesProvider provider) => Container(
        margin: const EdgeInsets.only(top: 160),
        alignment: Alignment.topCenter,
        decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                blurRadius: 10,
                spreadRadius: 0,
                blurStyle: BlurStyle.outer,
                offset: Offset(0, -1),
                color: Colors.white,
              )
            ],
            color: AppColors.secundaryColor,
            borderRadius: BorderRadius.circular(25)),
        padding: const EdgeInsets.all(15),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: provider.categories!.length,
          itemBuilder: (context, categoryIndex) =>
              closedCategoryWidget(provider, categoryIndex),
        ),
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
      body: Consumer<RegistriesProvider>(
        builder: (context, provider, child) => switch (provider.status) {
          RegistriesProviderStatus.loading => const Center(
              child: CircularProgressIndicator(),
            ),
          RegistriesProviderStatus.failed => Center(
              child: Text(provider.errorMessage!),
            ),
          RegistriesProviderStatus.loaded => Container(
              decoration:
                  const BoxDecoration(gradient: AppGradients.primaryColors),
              child: ValueListenableBuilder(
                  valueListenable: focusedCategoryIndex,
                  builder: (context, value, child) => Center(
                        child: AnimatedCrossFade(
                            alignment: Alignment.topCenter,
                            firstChild: _categoriesList(provider),
                            secondChild: openedCategoryWidget(
                                provider, focusedCategoryIndex.value),
                            crossFadeState: focusedCategoryIndex.value != null
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                            duration: const Duration(milliseconds: 500)),
                      )))
        },
      ),
    );
  }
}
