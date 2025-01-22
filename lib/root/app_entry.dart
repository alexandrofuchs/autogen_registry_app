import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:plain_registry_app/core/theme/app_theme.dart';
import 'package:plain_registry_app/workflow/home/presenter/providers/registries_provider.dart';
import 'package:plain_registry_app/workflow/home/presenter/registries_page.dart';
import 'package:provider/provider.dart';

class AppEntry extends StatelessWidget {
  const AppEntry({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.defaultTheme(context),
        home: ChangeNotifierProvider<RegistriesProvider>(
          create: (context) => RegistriesProvider(GetIt.I.get()),
          child: const RegistriesPage(),
        ));
  }
}
