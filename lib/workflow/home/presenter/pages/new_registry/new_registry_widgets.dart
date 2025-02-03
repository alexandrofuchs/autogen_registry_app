part of 'new_registry_page.dart';

mixin NewRegistryWidgets on CommonWidgets{
  late final ValueNotifier<int> _selectedGroupIndex;
  late final ValueNotifier<int> _selectedFileTypeIndex;

  late final TextInputValidator _descriptionTextInput;
  late final TextInputValidator _groupTextInput;

  late final List<String> _groupsToSelect;


  Widget selectField<DataType extends Object>(List<DataType> options,
          ValueNotifier<int> selectedValue, Function(int value) onSelected) =>
      fieldContainer(
          child: ValueListenableBuilder(
              valueListenable: selectedValue,
              builder: (context, value, child) => DropdownButton<int>(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 5, bottom: 5),
                    elevation: 0,
                    alignment: Alignment.centerRight,
                    isExpanded: true,
                    value: selectedValue.value,
                    style: AppTextStyles.labelStyleSmall,
                    dropdownColor: AppColors.primaryColorDark,
                    iconEnabledColor: AppColors.secundaryColor,
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
              inputValidator: _groupTextInput,
              errorText: 'Informe o nome do grupo',
            )
          : const SizedBox());

  Widget descriptionTextField() => TextInputBuilder(
                  label: 'Uma breve descrição...',
                  errorText: 'Descreva o registro',
                  inputValidator: _descriptionTextInput,
                  maxLength: 50,
                );
}