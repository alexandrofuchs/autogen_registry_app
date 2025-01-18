import 'package:flutter/material.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_text_styles.dart';
import 'package:plain_registry_app/core/widgets/common/common_widgets.dart';

mixin NewRegistryWidget on CommonWidgets {
  
  final _options = [
    'Selecione o tipo do arquivo',
    'Um',
    'Dois',
    'Tres',
  ];

  late ValueNotifier<int> selectedFileType;

  Widget selectFields(
          List<String> options, ValueNotifier<int> selectedFileType) =>
      fieldContainer(
          child: ValueListenableBuilder(
              valueListenable: selectedFileType,
              builder: (context, value, child) => DropdownButton<int>(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 5, bottom: 05),
                    elevation: 1,
                    alignment: Alignment.centerRight,
                    isExpanded: true,
                    value: selectedFileType.value,
                    style: AppTextStyles.bodyStyleSmall,
                    items: options
                        .map<DropdownMenuItem<int>>((e) => DropdownMenuItem(
                              value: options.indexOf(e),
                              child: Text(e),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      selectedFileType.value = value;
                    },
                  )));

  Future<T?> openNewRegistry<T>(BuildContext context) async =>
      await showAdaptiveDialog<T>(
          context: context,
          builder: (context) => Scaffold(
                resizeToAvoidBottomInset: true,
                persistentFooterAlignment: AlignmentDirectional.bottomCenter,
                backgroundColor: Colors.transparent,
                body: Container(
                  margin: const EdgeInsets.only(top: 150),
                  decoration: BoxDecoration(
                    gradient: AppGradients.primaryColors,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25))
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child:  headerContainer('Novo arquivo: toque para fechar'),),
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            
                            textField(
                                'um arquivo pdf', TextEditingController()),
                            selectFields(_options, selectedFileType),
                            const SizedBox(height: 15),
                            actionButton('AVANÇAR', () {}, false)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ));
}
