part of '../chat_page.dart';

class InitChatWidget extends StatefulWidget {
  final RegistryModel registry;
  final ValueNotifier<bool> loadingMessage;
  final TextMessageController textMessageController;

  const InitChatWidget(
      {super.key,
      required this.registry,
      required this.textMessageController,
      required this.loadingMessage});

  @override
  State<StatefulWidget> createState() => _InitChatWidgetState();
}

class _InitChatWidgetState extends State<InitChatWidget> with CommonWidgets {
  late final TextInputValidator _instructionTextInput;
  late final TextInputValidator _contentTextInput;

  @override
  void initState() {
    _instructionTextInput = TextInputValidator();
    _contentTextInput = TextInputValidator();

    super.initState();
  }

  @override
  void dispose() {
    _instructionTextInput.dispose();
    _contentTextInput.dispose();
    super.dispose();
  }

  Widget textMessage() => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Seu texto:\n',
                style: AppTextStyles.labelStyleMedium
                    .copyWith(fontWeight: FontWeight.bold)),
            ValueListenableBuilder(
                valueListenable: _instructionTextInput.controller,
                builder: (context, value, child) => value.text.isEmpty
                    ? const SizedBox()
                    : Text('${value.text}: ',
                        style: AppTextStyles.labelStyleMedium
                            .copyWith(fontWeight: FontWeight.w500))),
            ValueListenableBuilder(
                valueListenable: _contentTextInput.controller,
                builder: (context, value, child) => value.text.isEmpty
                    ? const SizedBox()
                    : Text('${value.text}.',
                        style: AppTextStyles.labelStyleMedium.copyWith(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.italic))),
          ]);

  Widget actions() => ValueListenableBuilder(
      valueListenable: widget.loadingMessage,
      builder: (context, isLoading, child) => isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                negativeActionButton('Cancelar', () {
                  Navigator.pop(context);
                }),
                positiveActionButton('Iniciar conversa', () async {
                  final messages = [
                    TextMessage(
                        id: DateTime.now().millisecondsSinceEpoch,
                        sender: MessageSender.user,
                        text:
                            "${_instructionTextInput.text}: ${_contentTextInput.text}")
                  ];
                  widget.loadingMessage.value = true;
                  widget.textMessageController.generateAnswer(messages);
                }),
              ],
            ));

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(gradient: AppGradients.primaryColors),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  TextInputBuilder(
                      errorText: 'digite uma instrução',
                      label: 'uma instrução especifica: Exemplo: treino de inglês',
                      inputValidator: _instructionTextInput,
                      maxLength: 30),
                  TextInputBuilder(
                      label: 'Digite o conteúdo: exemplo: elabore um texto sem usar conectivos e me opções para completar',
                      inputValidator: _contentTextInput,
                      errorText: '',
                      maxLength: 200,
                      maxLines: 3),
                  Container(
                    constraints: const BoxConstraints(minHeight: 200),
                    margin: const EdgeInsets.all(15),
                    padding: const EdgeInsets.all(25),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: AppColors.primaryColorLight, width: 2),
                          borderRadius: BorderRadius.only(
                             bottomLeft: Radius.circular(5),
                             topRight: Radius.circular(5),
                              topLeft: Radius.circular(25),
                              bottomRight: Radius.circular(25))),
                      color: AppColors.primaryColorDark,
                    ),
                    child: textMessage(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: actions(),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
