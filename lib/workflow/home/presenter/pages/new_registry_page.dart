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
import 'package:plain_registry_app/workflow/home/presenter/providers/registries_provider.dart';
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

  late final List<String> _categories;

  late final ValueNotifier<int> _selectedCategoryIndex;
  late final ValueNotifier<int> _selectedFileTypeIndex;

  late final TextEditingController _descriptionController;
  late final TextEditingController _filenameController;
  late final TextEditingController _categoryController;

  @override
  void initState() {
    _selectedCategoryIndex = ValueNotifier(0);
    _selectedFileTypeIndex = ValueNotifier(0);

    _categories = [
      'Selecione uma categoria...',
      'Nova categoria',
      ...context
          .read<RegistriesProvider>()
          .categories
          .map<String>((e) => e.name)
    ];

    _fileTypeOptions = RegistryType.values.map((e) => e.value).toList();

    _categoryController = TextEditingController();
    _filenameController = TextEditingController();
    _descriptionController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _selectedFileTypeIndex.dispose();
    _selectedCategoryIndex.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _filenameController.dispose();
    super.dispose();
  }

  void validateAndCreateFileAction() {

    if(_selectedCategoryIndex.value == 0){
      AppSnackbars.showErrorSnackbar(context, 'Selecione ou crie uma categoria');
      return;
    }

    if (![
      _categoryController.text.isNotEmpty,
      _filenameController.text.isNotEmpty,
      _descriptionController.text.isNotEmpty,
    ].every((e) => e)) {
      AppSnackbars.showErrorSnackbar(
          context, 'preencha todos os campos corretamente');
      return;
    }

    late RegistryType itemType =
        RegistryType.fromString(_fileTypeOptions[_selectedFileTypeIndex.value]);

    final item = RegistryModel(
        filename: _filenameController.text,
        description: _descriptionController.text,
        category: _categoryController.text,
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
          child: ChatPage())));
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

  Widget categoryTextField() => ValueListenableBuilder(
      valueListenable: _selectedCategoryIndex,
      builder: (context, value, child) => value == 1
          ? textField('nome da categoria', _categoryController)
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
                    selectFields(_categories, _selectedCategoryIndex, (value){
                      _selectedCategoryIndex.value = value;
                      if(value < 2){
                        _categoryController.text = '';
                        return;
                      }
                      _categoryController.text = _categories[value];
                    }),
                    categoryTextField(),
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
