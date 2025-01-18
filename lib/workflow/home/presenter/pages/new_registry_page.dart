import 'package:flutter/material.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_text_styles.dart';
import 'package:plain_registry_app/core/widgets/appbar/appbar_widgets.dart';
import 'package:plain_registry_app/core/widgets/common/common_widgets.dart';
import 'package:plain_registry_app/workflow/home/presenter/pages/widgets/new_registry_widget.dart';

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
        decoration: BoxDecoration(
          gradient: AppGradients.primaryColors,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          color: AppColors.primaryColor,
        ),
        height: 50,
        alignment: Alignment.center,
        child: Text(
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
          decoration: BoxDecoration(
              gradient: AppGradients.primaryColors,
              borderRadius: const BorderRadius.only(
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
                    actionButton('AVANÇAR', () {}, false)
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
