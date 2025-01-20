import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:plain_registry_app/core/helpers/formatters/datetime_formatters.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_text_styles.dart';
import 'package:plain_registry_app/core/widgets/appbar/appbar_widgets.dart';
import 'package:plain_registry_app/core/widgets/searchbar/searchbar_widget.dart';
import 'package:plain_registry_app/core/widgets/common/common_widgets.dart';
import 'package:plain_registry_app/workflow/home/presenter/pages/new_registry_page.dart';
import 'package:plain_registry_app/workflow/home/presenter/providers/registries_provider.dart';
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
          Navigator.of(context).push(_createRoute());
        },
        child: headerContainer('Adicionar novo arquivo'),
      );

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const NewRegistryPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Widget openedCategoryWidget(RegistriesProvider provider, int categoryIndex) =>
      Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              gradient: AppGradients.primaryColors,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(5),
                  bottomRight: Radius.circular(0)),
            ),
            padding:
                const EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 25),
            margin: const EdgeInsets.only(right: 25, top: 10),
            child: Text(
              provider.categories![categoryIndex].name,
              style: AppTextStyles.labelStyleMedium,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 25),
            padding: const EdgeInsets.only(right: 15),
            color: AppColors.secundaryColor,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: provider.categories![categoryIndex].items.length,
              itemBuilder: (context, index) => item(
                      fileIcons[index],
                      provider
                          .categories![categoryIndex].items[index].description,
                      '${provider.categories![categoryIndex].items[index].category} | ${provider.categories![categoryIndex].items[index].dateTime.toDaysNumberPast()}')
                  .animate()
                  .moveX(
                      begin: -1000,
                      end: 0,
                      delay: Duration(milliseconds: 500 * index)),
            ),
          ),
        ],
      );

  Widget closedCategoryWidget(RegistriesProvider provider, int categoryIndex) =>
      GestureDetector(
        onTap: () {
          focusedCategoryIndex.value = categoryIndex;
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: AppGradients.primaryColors,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(5), bottomRight: Radius.circular(0)),
          ),
          padding: const EdgeInsets.only(left: 5, top: 5, bottom: 5, right: 25),
          margin: const EdgeInsets.only(right: 25, top: 10),
          child: Text(
            provider.categories![categoryIndex].name,
            style: AppTextStyles.labelStyleMedium,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: appBarBottom(
            child: searchBar(
              (value) {
                context.read<RegistriesProvider>().categoryFilter = value;
              },
            ),
            label: 'Registros'),
      ),
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: footer(),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Column(
          children: [
            unselectedFilterBar(),
            divider(),
            Consumer<RegistriesProvider>(
              builder: (context, provider, child) => switch (provider.status) {
                RegistriesProviderStatus.loading => const Center(
                    child: CircularProgressIndicator(),
                  ),
                RegistriesProviderStatus.failed => Center(
                    child: Text(provider.errorMessage!),
                  ),
                RegistriesProviderStatus.loaded => Expanded(
                      child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: provider.categories!.length,
                    itemBuilder: (context, categoryIndex) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ValueListenableBuilder(
                            valueListenable: focusedCategoryIndex,
                            builder: (context, value, child) =>
                                AnimatedCrossFade(
                                    firstChild: closedCategoryWidget(
                                        provider, categoryIndex),
                                    secondChild: openedCategoryWidget(
                                        provider, categoryIndex),
                                    crossFadeState: value == categoryIndex
                                        ? CrossFadeState.showSecond
                                        : CrossFadeState.showFirst,
                                    duration:
                                        const Duration(milliseconds: 500)))
                      ],
                    ),
                  ))
              },
            ),
          ],
        ),
      ),
    );
  }
}
