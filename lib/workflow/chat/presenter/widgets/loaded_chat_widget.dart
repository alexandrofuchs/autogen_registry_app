part of '../chat_page.dart';

class LoadedChatWidget extends StatefulWidget {
  final ValueNotifier<bool> loadingMessage;
  final TextMessageController textMessageController;

  const LoadedChatWidget({super.key, required this.textMessageController, required this.loadingMessage});

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


  Future<void> showNewMessageModal([TextMessage? message]) async {

    _messageTextInput.text =  message == null ? '' : 'Detalhe pra mim sobre o seguinte trecho:\n\n "${
      message.text.replaceAll('**', ' ').replaceAll('_', '').replaceAll('\n', '')}"';
    _messageTextInput.hasError = false;
     await showModalBottomSheet(
                context: context,
                builder: (context) => newMessageField(message),
                isScrollControlled: true,
              );
  }


  Widget _textMessageBody(TextMessage message) => 
    Padding(
        padding: const EdgeInsets.all(5),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Markdown(
              padding: const EdgeInsets.only(right: 30, top: 25, left: 15, bottom: 25),
                shrinkWrap: true,
                selectable: true,
                softLineBreak: true,
                onSelectionChanged: (text, selection, cause) async {
                  if(text == null) return;
                  debugPrint(text);
                   await showNewMessageModal(TextMessage(id: message.id, sender: message.sender, text: text));
                },
                physics: const NeverScrollableScrollPhysics(),
                styleSheetTheme: MarkdownStyleSheetBaseTheme.material,
                styleSheet: MarkdownStyleSheet(
                  a: AppTextStyles.labelStyleSmall,
                  blockquote: AppTextStyles.labelStyleSmall,
                  checkbox: AppTextStyles.labelStyleSmall,
                  del: AppTextStyles.labelStyleSmall,
                  em: AppTextStyles.labelStyleSmall,
                  h1: AppTextStyles.labelStyleSmall,
                  h2: AppTextStyles.labelStyleSmall.copyWith(fontSize: 11),
                  h3: AppTextStyles.labelStyleSmall.copyWith(fontSize: 10),
                  h4: AppTextStyles.labelStyleSmall.copyWith(fontSize: 9),
                  h5: AppTextStyles.labelStyleSmall.copyWith(fontSize: 8),
                  h6: AppTextStyles.labelStyleSmall.copyWith(fontSize: 7),
                  img: AppTextStyles.labelStyleSmall,
                  listBullet: AppTextStyles.labelStyleSmall,
                  tableHead: AppTextStyles.labelStyleSmall,
                  textAlign: WrapAlignment.start,
                  p: AppTextStyles.labelStyleSmall,
                  h1Align: WrapAlignment.center,
                  strong: AppTextStyles.labelStyleMedium.copyWith(fontWeight: FontWeight.w700),
                  codeblockPadding: const EdgeInsets.all(15),
                  code: AppTextStyles.labelStyleSmall,
                  tableBody: AppTextStyles.labelStyleSmall.copyWith(fontSize: 8),
                  tableCellsPadding: const EdgeInsets.all(2),
                  tableBorder: TableBorder.all(color: AppColors.primaryColorLight),
                  codeblockDecoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: Colors.black),
                  
                 
                  
                ),
                data: message.text),
          toolWidget(context, Icons.reply_outlined, 'a', action: () {
            showNewMessageModal(message);
          },),
          ],
          
        ),
      );

  Widget _textMessageHeader(TextMessage message) => Container(
        alignment: Alignment.topRight,
        decoration: ShapeDecoration(shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(
          topLeft: Radius.circular(100),
          bottomRight: Radius.circular(100),
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(25)
          )),
        color: Colors.black.withAlpha(100)),

        padding: const EdgeInsets.only(right: 25, left: 25, top: 10, bottom: 10),
        child: Text(
          "${message.sender.label} - ${DateTime.fromMillisecondsSinceEpoch(message.id).toDateString()} ${DateTime.fromMillisecondsSinceEpoch(message.id).toHourString()}",
          textAlign: TextAlign.right,
          style: AppTextStyles.labelStyleSmall
              .copyWith(fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),
        ),
      );

  Widget textMessageWidget(TextMessage message) => Container(
        margin: const EdgeInsets.only(top: 15, bottom: 7.5, left: 5, right: 5),
        decoration:  ShapeDecoration(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(35))),
              shadows: const [
                BoxShadow(spreadRadius: 1, blurRadius: 5, offset: Offset(0, 0), color: AppColors.primaryColorLight),
                BoxShadow(color: AppColors.primaryColor),
              ],
          color: AppColors.primaryColorDark.withAlpha(0)
        ),
        child: Column(
          children: [
            _textMessageHeader(message),
            _textMessageBody(message),
          ],
        ),
      );

  Widget title(String text) =>
    Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15, top: 25),
                        child: Text(text, style: AppTextStyles.labelStyleLarge,),
                      );

  Widget newMessageField([TextMessage? textMessage]) => Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SafeArea(
          child: Container(
              decoration: const BoxDecoration(gradient: AppGradients.primaryColors),
            padding: const EdgeInsets.only(top: 75),
            child:  Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        
                        
                        textMessage != null ?
                          ValueListenableBuilder(valueListenable: _messageTextInput.controller, builder:(context, value, child) => 
                            Padding(
                              padding: const EdgeInsets.all(25),
                              child: textMessageWidget(textMessage),
                            )
                                
                            
                          ) : const SizedBox(),
                    
                        title('Personalize a sua mensagem abaixo: '),
                       
                        Container(
                          margin: const EdgeInsets.all(0),
                          padding: const EdgeInsets.all(0),
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          child: Stack(
                            children: [
                              TextInputBuilder(
                                errorText: 'mensagem inválida',
                                maxLines: 10,
                                inputValidator: _messageTextInput,
                                label: 'Digite sua mensagem...',
                                padding: const EdgeInsets.only(right: 50, bottom: 15, left: 15, top: 15),
                              ),
                               Container(
                                padding: const EdgeInsets.only(right: 25, top: 25),
                                alignment: Alignment.topRight,
                                child: toolWidget(
                                    context, Icons.clear, 'LIMPAR', action: () {
                                  _messageTextInput.text = '';
                                }),
                              ),
                            ],
                          ),
                        ),
                        
                      ],
                    ),
                  ),
                  Container(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: 
                          Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            negativeActionButton('VOLTAR', () {
                              Navigator.pop(context);
                            }),
                            positiveActionButton('ENVIAR', ()  {

                              if(_messageTextInput.text.isEmpty){
                                AppSnackbars.showErrorSnackbar(context, 'Digite alguma instrução');
                                return;
                              } 

                              final messages = [
                                ...context.read<ChatProvider>().chat.messages,
                                TextMessage(
                                    id: DateTime.now().millisecondsSinceEpoch,
                                    sender: MessageSender.user,
                                    text: _messageTextInput.text)
                              ];
                  
                              widget.loadingMessage.value = true;
                              widget.textMessageController.generateAnswer(messages);
                              if(!mounted) return;
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
    ValueListenableBuilder(
                          valueListenable: widget.loadingMessage, builder:(context, isLoading, child) => 
                            isLoading ?
                              Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(5),  
                                child: const CircularProgressIndicator(),) : child ?? const SizedBox(),
                              child: GestureDetector(
            onTap: () {
              showNewMessageModal();
            },
            child: 
            Container(
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
          ));

  Widget tipWidget() =>
    ValueListenableBuilder(valueListenable: showTipText, builder:(context, show, child) => 
      !show ? const SizedBox() :
      Container(
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              
              borderRadius: BorderRadius.circular(5),
              boxShadow: const [
                
                BoxShadow(color: Colors.white, spreadRadius: 0, blurRadius: 5,
                  blurStyle: BlurStyle.solid
                )
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

  Widget toolsWidget() =>
    Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
      toolWidget(context, Icons.share, 'share'),
      toolWidget(context, Icons.picture_as_pdf, 'pdf'),
    ],);

  @override
  Widget build(BuildContext context) => Column(
        children: [
          tipWidget(),
          toolsWidget(),
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
