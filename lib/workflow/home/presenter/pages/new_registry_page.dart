import 'package:flutter/material.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_gradients.dart';
import 'package:plain_registry_app/core/theme/app_text_styles.dart';
import 'package:plain_registry_app/core/widgets/appbar/appbar_widgets.dart';
import 'package:plain_registry_app/core/widgets/common/common_widgets.dart';
import 'package:plain_registry_app/workflow/home/domain/models/registry_model.dart';
import 'package:plain_registry_app/workflow/home/presenter/pages/media/media_home_page.dart';
import 'package:plain_registry_app/workflow/home/presenter/providers/registries_provider.dart';
import 'package:plain_registry_app/workflow/root/app_router.dart';
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
          .categories.map<String>((e) => e.name)
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

  void createFileAction() {
    Navigator.push(
        context,
        AppRouter.createRoute(MediaHomePage(
            model: RegistryModel(
                filename: 'filename',
                description: 'Um novo arquivo',
                category: 'treinos',
                dateTime: DateTime.now(),
                type: RegistryType.image))));
  }

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
            Icon(Icons.arrow_back, color: AppColors.secundaryColor,),
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
          border: const Border(top: BorderSide(color: AppColors.primaryColorLight),
          ),
          borderRadius: BorderRadius.circular(25)
        ),
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
                    selectFields(_categories, _selectedCategoryIndex),
                    selectFields(_fileTypeOptions, _selectedFileTypeIndex),
                    textField('nome do arquivo', _filenameController),
                    textField('descrição', _descriptionController),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        negativeActionButton(
                            'RETORNAR', () => Navigator.pop(context)),
                        positiveActionButton(
                            'AVANÇAR', createFileAction),
                      ],
                    )
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
