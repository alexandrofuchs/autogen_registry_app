import 'package:flutter/material.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_text_styles.dart';
import 'package:plain_registry_app/core/widgets/appbar/appbar_widgets.dart';
import 'package:plain_registry_app/core/widgets/common/common_widgets.dart';
import 'package:plain_registry_app/workflow/home/domain/models/registry_model.dart';
import 'package:plain_registry_app/workflow/home/presenter/pages/media/media_home_page.dart';
import 'package:plain_registry_app/workflow/home/presenter/pages/widgets/new_registry_widget.dart';
import 'package:plain_registry_app/workflow/root/app_router.dart';

class NewRegistryPage extends StatefulWidget {
  const NewRegistryPage({super.key});

  @override
  State<StatefulWidget> createState() => _NewRegistryPageState();
}

class _NewRegistryPageState extends State<NewRegistryPage>
    with CommonWidgets, AppbarWidgets, NewRegistryWidget {
  final _options = [
    'Selecione o tipo do arquivo',
    'Um',
    'Dois',
    'Tres',
  ];

  @override
  void initState() {
    selectedFileType = ValueNotifier(0);
    super.initState();
  }

  @override
  void dispose() {
    selectedFileType.dispose();
    super.dispose();
  }

  Widget addNewFileButtomHeader() => Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.primaryColors,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          color: AppColors.primaryColor,
        ),
        height: 50,
        alignment: Alignment.center,
        child: const Text(
          'Adicionar novo arquivo',
          style: AppTextStyles.labelStyleLarge,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: true,
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(),
        child: Container(
          margin: const EdgeInsets.only(top: 50),
          decoration: const BoxDecoration(
              gradient: AppGradients.primaryColors,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25), topRight: Radius.circular(25))),
          child: Column(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: addNewFileButtomHeader()),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    textField('um arquivo pdf', TextEditingController()),
                    selectFields(_options, selectedFileType),
                    const SizedBox(height: 15),
                    actionButton('AVANÇAR', () {
                      Navigator.push(
                          context,
                          AppRouter.createRoute(MediaHomePage(
                              model: RegistryModel(
                                  filename: 'filename',
                                  description: 'Um novo arquivo',
                                  category: 'treinos',
                                  dateTime: DateTime.now(),
                                  type: RegistryType.image))));
                    }, true)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
