import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:plain_registry_app/core/common/text_input/text_input_validator.dart';
import 'package:plain_registry_app/core/common/text_input/text_input_builder.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_gradients.dart';
import 'package:plain_registry_app/core/theme/app_text_styles.dart';
import 'package:plain_registry_app/core/widgets/appbar/appbar_widgets.dart';
import 'package:plain_registry_app/core/widgets/common/common_widgets.dart';
import 'package:plain_registry_app/core/widgets/snackbars/app_snackbars.dart';
import 'package:plain_registry_app/workflow/home/domain/models/loaded_file.dart';
import 'package:plain_registry_app/workflow/home/domain/models/registry_model.dart';
import 'package:plain_registry_app/workflow/chat/presenter/chat_page.dart';
import 'package:plain_registry_app/workflow/chat/presenter/chat_provider.dart';
import 'package:plain_registry_app/workflow/home/presenter/pages/media/media_home_page.dart';
import 'package:plain_registry_app/workflow/home/presenter/providers/registry_groups_provider.dart';
import 'package:plain_registry_app/root/app_router.dart';
import 'package:provider/provider.dart';

class NewRegistryPage extends StatefulWidget {
  const NewRegistryPage({super.key});

  @override
  State<StatefulWidget> createState() => _NewRegistryPageState();
}

class _NewRegistryPageState extends State<NewRegistryPage>
    with CommonWidgets, AppbarWidgets {
  late final List<String> _fileTypeOptions;

  late final List<String> _groups;

  late final ValueNotifier<int> _selectedGroupIndex;
  late final ValueNotifier<int> _selectedFileTypeIndex;

  late final TextInputValidator _descriptionTextInput;
  late final TextInputValidator _filenameTextInput;
  late final TextInputValidator _groupTextInput;

  @override
  void initState() {
    _selectedGroupIndex = ValueNotifier(0);
    _selectedFileTypeIndex = ValueNotifier(0);

    _groups = [
      'Selecione um grupo...',
      'Novo grupo',
      ...context
          .read<RegistryGroupsProvider>()
          .groups
    ];

    _fileTypeOptions = RegistryType.values.map((e) => e.value).toList();

    _groupTextInput = TextInputValidator();
    _filenameTextInput = TextInputValidator();
    _descriptionTextInput = TextInputValidator();

    super.initState();
  }

  @override
  void dispose() {
    _selectedFileTypeIndex.dispose();
    _selectedGroupIndex.dispose();
    _descriptionTextInput.dispose();
    _groupTextInput.dispose();
    _filenameTextInput.dispose();
    super.dispose();
  }

  void validateAndCreateFileAction() {

    if(_selectedGroupIndex.value == 0){
      AppSnackbars.showErrorSnackbar(context, 'Selecione ou crie um grupo');
      return;
    }

    _descriptionTextInput.hasError = _descriptionTextInput.text.isEmpty;
    _groupTextInput.hasError = _groupTextInput.text.isEmpty;

    if (![
      _groupTextInput.controller.text.isNotEmpty,
      _descriptionTextInput.controller.text.isNotEmpty,
    ].every((e) => e)) {
      AppSnackbars.showErrorSnackbar(
          context, 'preencha todos os campos corretamente');
      return;
    }

    late RegistryType itemType =
        RegistryType.fromString(_fileTypeOptions[_selectedFileTypeIndex.value]);

    final item = RegistryModel(
        id: null,
        topic: 'a',
        contentData: null,
        contentName: null,
        contentType: itemType,
        description: _descriptionTextInput.controller.text,
        group: _groupTextInput.controller.text,
        dateTime: DateTime.now(),
        );

    switch (RegistryType.fromString(
        _fileTypeOptions[_selectedFileTypeIndex.value])) {
      case RegistryType.document:
        break;
      case RegistryType.video:
        Navigator.push(
            context, AppRouter.createRoute(MediaHomePage(model: item, mediaType: MediaType.video,)));
        break;
      case RegistryType.image:
        Navigator.push(
            context, AppRouter.createRoute(MediaHomePage(model: item, mediaType: MediaType.image,)));
        break;
      case RegistryType.audio:
        break;
      case RegistryType.textGeneration:
        Navigator.push(context, AppRouter.createRoute(
          ChangeNotifierProvider(create: (context) => ChatProvider(GetIt.I.get()),
          child: ChatPage(registry: item,))));
        break;
    }
  }

  Widget selectFields<DataType extends Object>(
          List<DataType> options, ValueNotifier<int> selectedValue, Function(int value) onSelected) =>
      fieldContainer(
          child: ValueListenableBuilder(
              valueListenable: selectedValue,
              builder: (context, value, child) => DropdownButton<int>(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 5, bottom: 05),
                    elevation: 1,
                    alignment: Alignment.centerRight,
                    isExpanded: true,
                    value: selectedValue.value,
                    style: AppTextStyles.bodyStyleSmall,
                    items: options
                        .map<DropdownMenuItem<int>>((e) => DropdownMenuItem(
                              value: options.indexOf(e),
                              child: Text(e.toString()),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value == null) return;
                      onSelected(value);
                    },
                  )));

  Widget addNewFileButtomHeader() => Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.primaryColors,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
          color: AppColors.primaryColor,
        ),
        height: 50,
        alignment: Alignment.center,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.arrow_back,
              color: AppColors.secundaryColor,
            ),
            Text(
              'Adicionar novo arquivo',
              style: AppTextStyles.labelStyleLarge,
            ),
          ],
        ),
      );

  Widget groupTextField() => ValueListenableBuilder(
      valueListenable: _selectedGroupIndex,
      builder: (context, value, child) => value == 1
          ? TextInputBuilder(
            label: 'Nome do grupo...', 
            inputValidator:  _groupTextInput,
            errorText: 'Informe o nome do grupo',
            )
          : const SizedBox());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 10),
      resizeToAvoidBottomInset: true,
      persistentFooterAlignment: AlignmentDirectional.bottomCenter,
      backgroundColor: AppColors.primaryColor,
      body: Container(
        decoration: BoxDecoration(
            color: AppColors.primaryColor,
            border: const Border(
              top: BorderSide(color: AppColors.primaryColorLight),
            ),
            borderRadius: BorderRadius.circular(25)),
        child: Container(
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
                    selectFields(RegistryType.values, _selectedFileTypeIndex,(value){
                      _selectedFileTypeIndex.value = value;
                    }),
                    selectFields(_groups, _selectedGroupIndex, (value){
                      _selectedGroupIndex.value = value;
                      if(value < 2){
                        _groupTextInput.text = '';
                        return;
                      }
                      _groupTextInput.text = _groups[value];
                    }),
                    groupTextField(),
                    TextInputBuilder(
                      label: 'Uma breve descrição...', 
                      errorText: 'Descreva o registro',
                      inputValidator: _descriptionTextInput, 
                      maxLength: 50,
                    ),
                   
                    const SizedBox(height: 15),
                  ])),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 25),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          negativeActionButton(
                              'RETORNAR', () => Navigator.pop(context)),
                          positiveActionButton('AVANÇAR', validateAndCreateFileAction),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            
          
        
      ),
    );
  }
}
