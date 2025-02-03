import 'package:autogen_registry_app/core/widgets/common/common_widgets.dart';
import 'package:autogen_registry_app/workflow/home/home_worflow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:autogen_registry_app/core/helpers/formatters/datetime_formatters.dart';
import 'package:autogen_registry_app/core/theme/app_colors.dart';
import 'package:autogen_registry_app/core/theme/app_gradients.dart';
import 'package:autogen_registry_app/core/theme/app_text_styles.dart';
import 'package:autogen_registry_app/core/widgets/searchbar/searchbar_widget.dart';
import 'package:autogen_registry_app/core/widgets/snackbars/app_snackbars.dart';
import 'package:autogen_registry_app/root/app_router.dart';
import 'package:autogen_registry_app/workflow/chat/chat_worflow.dart';
import 'package:autogen_registry_app/workflow/home/domain/models/registry_model.dart';
import 'package:autogen_registry_app/workflow/home/presenter/pages/registries/registries_provider.dart';
import 'package:provider/provider.dart';

part 'opened_registries_group_widgets.dart';

class OpenedRegistriesGroupPage extends StatefulWidget {
  final String group;
  const OpenedRegistriesGroupPage({super.key, required this.group});

  @override
  State<StatefulWidget> createState() => _OpenedRegistriesGroupPageState();
}

class _OpenedRegistriesGroupPageState extends State<OpenedRegistriesGroupPage>
    with SearchbarWidget, OpenedRegistriesGroupWidgets, CommonWidgets {
  @override
  initState() {
    context.read<RegistriesProvider>().loadByGroup(widget.group);
    super.initState();
  }

  @override
  void dispose() {
    // context.read<RegistriesProvider>().dispose();
    super.dispose();
  }

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
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(context, AppRouter.route(HomeWorflow.newRegistryPage(specificGroup: widget.group)));
        },
        child: titleContainer('Grupo ${widget.group}: novo registro')),
      body: openedGroupWidget(),
    );
  }
}
