part of '../chat_page.dart';

class InitChatWidget extends StatefulWidget {
  final RegistryModel registry;
  final TextMessageController textMessageController;

  const InitChatWidget(
      {super.key, required this.registry, required this.textMessageController});

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

  

  @override
  Widget build(BuildContext context) => Container(
        decoration: const BoxDecoration(gradient: AppGradients.primaryColors),
        child: ListView(
          children: [
            TextInputBuilder(
                errorText: '',
                label: 'Digite uma instrução especifica',
                inputValidator: _instructionTextInput,
                maxLength: 30),
            TextInputBuilder(
                label: 'Digite o conteúdo ou contexto da instrução',
                inputValidator: _contentTextInput,
                errorText: '',
                maxLength: 200,
                maxLines: 3),
            Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.primaryColorDark,
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
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
                                  style: AppTextStyles.labelStyleMedium
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.italic))),
                    ]),
              ),
            ),
            Row(
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

                  widget.textMessageController.generateAnswer(messages);
                }),
              ],
            )
          ],
        ),
      );
}
