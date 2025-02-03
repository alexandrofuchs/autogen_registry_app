import 'package:autogen_registry_app/workflow/chat/chat_worflow.dart';
import 'package:flutter/material.dart';
import 'package:autogen_registry_app/core/common/text_input/text_input_validator.dart';
import 'package:autogen_registry_app/core/common/text_input/text_input_builder.dart';
import 'package:autogen_registry_app/core/theme/app_colors.dart';
import 'package:autogen_registry_app/core/theme/app_gradients.dart';
import 'package:autogen_registry_app/core/theme/app_text_styles.dart';
import 'package:autogen_registry_app/core/widgets/common/common_widgets.dart';
import 'package:autogen_registry_app/core/widgets/snackbars/app_snackbars.dart';
import 'package:autogen_registry_app/workflow/home/domain/models/registry_model.dart';
import 'package:autogen_registry_app/root/app_router.dart';

part 'new_registry_widgets.dart';

class NewRegistryPage extends StatefulWidget {
  final List<String>? groups;
  final String? specificGroup;

  const NewRegistryPage({super.key, required this.groups, this.specificGroup});

  @override
  State<StatefulWidget> createState() => _NewRegistryPageState();
}

class _NewRegistryPageState extends State<NewRegistryPage>
    with CommonWidgets, NewRegistryWidgets {
  
  @override
  void initState() {
    _selectedGroupIndex = ValueNotifier(0);
    _selectedFileTypeIndex = ValueNotifier(0);

    if(widget.specificGroup != null){
      _groupsToSelect = [widget.specificGroup!];
    }else {
      _groupsToSelect = [
      'Selecione um grupo...',
      'Novo grupo',
      ...(widget.groups ?? []),
    ];
    }

    _groupTextInput = TextInputValidator();
    _descriptionTextInput = TextInputValidator();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _selectedFileTypeIndex.dispose();
    _selectedGroupIndex.dispose();
    _groupTextInput.dispose();
    _descriptionTextInput.dispose();
  }

  void validateAndCreateFileAction() {
    if (_selectedGroupIndex.value == 0 && _groupsToSelect.length > 1) {
      AppSnackbars.showErrorSnackbar(context, 'Selecione ou crie um grupo');
      return;
    }

    _descriptionTextInput.hasError = _descriptionTextInput.text.isEmpty;
    _groupTextInput.hasError = _groupTextInput.text.isEmpty;

    if (![
      _descriptionTextInput.text.isNotEmpty,
      _descriptionTextInput.text.isNotEmpty,
    ].every((e) => e)) {
      AppSnackbars.showErrorSnackbar(
          context, 'preencha todos os campos corretamente');
      return;
    }

    RegistryType itemType = RegistryType.values[_selectedFileTypeIndex.value];

    final item = RegistryModel(
      id: null,
      topic: '',
      contentData: null,
      contentName: null,
      contentType: itemType,
      description: _descriptionTextInput.controller.text,
      group: _groupTextInput.controller.text,
      dateTime: DateTime.now(),
    );

    switch (itemType) {
      case RegistryType.textGeneration:
        Navigator.pushReplacement(context, AppRouter.route(ChatWorkflow.chatPage(item)));
        break;
    }
  }

  Widget form() => ListView(shrinkWrap: true, children: [
        selectField(RegistryType.values, _selectedFileTypeIndex, (value) {
          _selectedFileTypeIndex.value = value;
        }),
        selectField(_groupsToSelect, _selectedGroupIndex, (value) {
          _selectedGroupIndex.value = value;
          if (value < 2) {
            _groupTextInput.text = '';
            return;
          }
          _groupTextInput.text = _groupsToSelect[value];
        }),
        groupTextField(),
        descriptionTextField(),
        const SizedBox(height: 15),
      ]);

  Widget actions() => Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            negativeActionButton('VOLTAR', () => Navigator.pop(context)),
            positiveActionButton('AVANÇAR', validateAndCreateFileAction),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Novo registro'),
      ),
      resizeToAvoidBottomInset: true,
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.primaryColors,
        ),
        child: Column(
          children: [
            Expanded(
              child: form(),
            ),
            actions(),
          ],
        )),
    );
  }
}
