import 'package:flutter/material.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_gradients.dart';
import 'package:plain_registry_app/core/theme/app_text_styles.dart';
import 'package:plain_registry_app/core/widgets/appbar/appbar_widgets.dart';
import 'package:plain_registry_app/core/widgets/common/common_widgets.dart';
import 'package:plain_registry_app/core/widgets/snackbars/app_snackbars.dart';
import 'package:plain_registry_app/workflow/home/domain/models/loaded_file.dart';
import 'package:plain_registry_app/workflow/home/domain/models/registry_model.dart';
import 'package:plain_registry_app/workflow/home/presenter/pages/chat/chat_page.dart';
import 'package:plain_registry_app/workflow/home/presenter/pages/chat/chat_provider.dart';
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

  late final TextEditingController _descriptionController;
  late final TextEditingController _filenameController;
  late final TextEditingController _groupController;

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

    _groupController = TextEditingController();
    _filenameController = TextEditingController();
    _descriptionController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _selectedFileTypeIndex.dispose();
    _selectedGroupIndex.dispose();
    _descriptionController.dispose();
    _groupController.dispose();
    _filenameController.dispose();
    super.dispose();
  }

  void validateAndCreateFileAction() {

    if(_selectedGroupIndex.value == 0){
      AppSnackbars.showErrorSnackbar(context, 'Selecione ou crie um grupo');
      return;
    }

    if (![
      _groupController.text.isNotEmpty,
      _filenameController.text.isNotEmpty,
      _descriptionController.text.isNotEmpty,
    ].every((e) => e)) {
      AppSnackbars.showErrorSnackbar(
          context, 'preencha todos os campos corretamente');
      return;
    }

    late RegistryType itemType =
        RegistryType.fromString(_fileTypeOptions[_selectedFileTypeIndex.value]);

    final item = RegistryModel<String>(
        id: 0,
        data: '',
        filename: _filenameController.text,
        description: _descriptionController.text,
        group: _groupController.text,
        dateTime: DateTime.now(),
        type: itemType);

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
      case RegistryType.text:
        Navigator.push(context, AppRouter.createRoute(
          ChangeNotifierProvider(create: (context) => ChatProvider()..loadData(),
          child: const ChatPage())));
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
          ? textField('nome do grupo', _groupController)
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
                    selectFields(_groups, _selectedGroupIndex, (value){
                      _selectedGroupIndex.value = value;
                      if(value < 2){
                        _groupController.text = '';
                        return;
                      }
                      _groupController.text = _groups[value];
                    }),
                    groupTextField(),
                    textField('nome do arquivo', _filenameController),
                    textField('descrição', _descriptionController),
                    selectFields(RegistryType.values, _selectedFileTypeIndex,(value){
                      _selectedFileTypeIndex.value = value;
                    }),
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
