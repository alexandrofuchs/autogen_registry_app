import 'package:flutter/material.dart';
import 'package:plain_registry_app/core/helpers/formatters/datetime_formatters.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: appBarBottom(child: searchBar((value) {
          context.read<RegistriesProvider>().filter = value;
        })),
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
                      itemCount: provider.items!.length,
                      itemBuilder: (context, index) => item(
                          fileIcons[index],
                          'Um arquivo pdf.',
                          '${provider.items![index].category} | ${provider.items![index].dateTime.toDaysNumberPast()}'),
                    ),
                  )
              },
            ),
          ],
        ),
      ),
    );
  }
}
