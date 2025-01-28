part of '../chat_page.dart';

class LoadedChatWidget extends StatefulWidget {
  final TextMessageController textMessageController;

  const LoadedChatWidget({super.key, required this.textMessageController});

  @override
  State<StatefulWidget> createState() => _LoadedChatWidgetState();
}

class _LoadedChatWidgetState extends State<LoadedChatWidget>
    with CommonWidgets {
  late final TextInputValidator _messageTextInput;

  ValueNotifier<bool> showTipText =  ValueNotifier(true);

  @override
  initState() {
    _messageTextInput = TextInputValidator();
    super.initState();
  }

  @override
  dispose() {
    _messageTextInput.dispose();
    super.dispose();
  }


  Future<void> showNewMessageModal([String? text]) async {
     await showModalBottomSheet(
                context: context,
                builder: (context) => newMessageField(text),
                isScrollControlled: true,
              );
  }


  Widget _textMessageBody(String text) => Padding(
        padding: const EdgeInsets.all(5),
        child: Markdown(
            shrinkWrap: true,
            selectable: true,
            softLineBreak: true,
            onSelectionChanged: (text, selection, cause) async {
              debugPrint(text);
               await showNewMessageModal(text);
            },
            physics: const NeverScrollableScrollPhysics(),
            styleSheet: MarkdownStyleSheet(
              textAlign: WrapAlignment.start,
              p: AppTextStyles.labelStyleSmall,
              h1Align: WrapAlignment.center,
              strong: AppTextStyles.labelStyleMedium.copyWith(fontWeight: FontWeight.w700),
              codeblockPadding: const EdgeInsets.all(15),
              code: AppTextStyles.labelStyleSmall,
              codeblockDecoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Colors.black),
              h1: AppTextStyles.labelStyleLarge,
              h2: AppTextStyles.labelStyleMedium,
              
            ),
            data: text.replaceAll('*', '')),
      );

  Widget _textMessageHeader(TextMessage message) => Container(
        alignment: Alignment.topRight,
        padding: const EdgeInsets.all(15),
        child: Text(
          "${message.sender.label} - ${DateTime.fromMillisecondsSinceEpoch(message.id).toDateString()} ${DateTime.fromMillisecondsSinceEpoch(message.id).toHourString()}",
          style: AppTextStyles.labelStyleSmall
              .copyWith(fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),
        ),
      );

  Widget textMessageWidget(TextMessage message) => Container(
        margin: const EdgeInsets.only(top: 15, bottom: 7.5),
        decoration: const ShapeDecoration(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(25))),
          gradient: AppGradients.primaryColorsDark,
        ),
        child: Column(
          children: [
            _textMessageHeader(message),
            _textMessageBody(message.text),
          ],
        ).animate().fadeIn(begin: 200, duration: const Duration(milliseconds: 300)),
      );

  Widget newMessageField([String? text]) => Scaffold(
        appBar: AppBar(toolbarHeight: 10,),
        backgroundColor: AppColors.primaryColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                titleContainer('Nova mensagem'),
                text != null ?
                  ValueListenableBuilder(valueListenable: _messageTextInput.controller, builder:(context, value, child) => Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 25),
                    child: Text(value.text, style: AppTextStyles.labelStyleMedium,),
                  )) : const SizedBox(),
            
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 25),
                  child: Text('Personalize a mensagem abaixo: ', style: AppTextStyles.labelStyleLarge,),
                ),
                Expanded(
                  child: ColoredBox(
                    color: AppColors.primaryColor,
                    child: Container(
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(0),
                      decoration: ShapeDecoration(
                        
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                      ),
                      child: TextInputBuilder(
                        errorText: 'mensagem invalida',
                        inputValidator: _messageTextInput..text = text == null? '' : 'Detalhe pra mim sobre o seguinte trecho:\n\n "$text"\n\n',
                        label: 'Digite sua mensagem...',
                      ),
                    ),
                  ),
                ),
                Container(
                  color: AppColors.primaryColor,
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      negativeActionButton('Cancelar', () {
                        Navigator.pop(context);
                      }),
                      positiveActionButton('Enviar', () {
                        final messages = [
                          ...context.read<ChatProvider>().chat.messages,
                          TextMessage(
                              id: DateTime.now().millisecondsSinceEpoch,
                              sender: MessageSender.user,
                              text: _messageTextInput.text)
                        ];
            
                        widget.textMessageController.generateAnswer(messages);
            
                        Navigator.pop(context);
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget newMessageWidget() =>
    GestureDetector(
            onTap: () {
              showNewMessageModal();
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 15, bottom: 15),
              padding: const EdgeInsets.all(15),
              decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                          bottomLeft: Radius.circular(5),
                          topRight: Radius.circular(5))),
                  color: AppColors.primaryColorDark),
              child: const Text(
                'ESCREVER',
                style: AppTextStyles.labelStyleMedium,
              ),
            ),
          );

  Widget tipWidget() =>
    ValueListenableBuilder(valueListenable: showTipText, builder:(context, show, child) => 
      !show ? const SizedBox() :
      Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              
              borderRadius: BorderRadius.circular(25),
              color: AppColors.backgroundColor,
              boxShadow: const [
                
                BoxShadow(color: AppColors.primaryColor)
              ]
            ),

            child:  Row(
              children: [
                const Icon(Icons.arrow_right, color: AppColors.primaryColorDark,).animate(
                  delay: const Duration(milliseconds: 700),
                  onPlay: (controller) => controller.repeat(),
                ).moveX(begin: -5, end: 5),
                 Expanded(child: Text(
                  'Você pode obter mais detalhes sobre um trecho selecionando-o e escrevendo uma nova mensagem complementar sobre o tópico!',
                  style: AppTextStyles.labelStyleSmall.copyWith(color: AppColors.primaryColorDark, fontWeight: FontWeight.w600),
                  softWrap: true,
                  )).animate().scale(
                    curve: Curves.easeIn,
                    begin: const Offset(0.5, 0.5),
                    end: const Offset(1.0, 1.0),
                    duration: const Duration(milliseconds: 1000)),
                IconButton(
                  padding: const EdgeInsets.all(5.0),
                  onPressed: () {
                    showTipText.value = false;
                  },
                  icon: const Icon(Icons.close, color: AppColors.primaryColorDark,),
                )
              ],
            ),
    ));

  @override
  Widget build(BuildContext context) => Column(
        children: [
          tipWidget(),
          Expanded(
            child: StreamBuilder<List<TextMessage>>(
                stream: widget.textMessageController.onNewMessage,
                initialData: context.read<ChatProvider>().chat.messages,
                builder: (context, snapshot) => snapshot.data != null
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) =>
                                textMessageWidget(snapshot.data![index]),
                            )
                    : const SizedBox()),
          ),
          newMessageWidget(),
        ],
      );

  
}
