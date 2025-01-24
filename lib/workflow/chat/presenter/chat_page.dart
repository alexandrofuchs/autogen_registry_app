import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get_it/get_it.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_gradients.dart';
import 'package:plain_registry_app/core/theme/app_text_styles.dart';
import 'package:plain_registry_app/core/widgets/common/common_widgets.dart';
import 'package:plain_registry_app/workflow/chat/domain/models/chat.dart';
import 'package:plain_registry_app/workflow/chat/domain/models/text_message.dart';
import 'package:plain_registry_app/workflow/chat/domain/models/new_text_message_model.dart';
import 'package:plain_registry_app/workflow/chat/presenter/chat_provider.dart';
import 'package:plain_registry_app/workflow/chat/presenter/text_message_provider.dart';
import 'package:plain_registry_app/workflow/home/domain/models/registry_model.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  final RegistryModel registry;

  const ChatPage({super.key, required this.registry});

  @override
  State<StatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with CommonWidgets {
  final _textMessageController = TextMessageController(GetIt.I.get());

  final _instructionController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  initState() {
    super.initState();
  }

  @override
  dispose() {
    _textMessageController.dispose();
    _instructionController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  Widget loadingChat() => const Center(child: CircularProgressIndicator());

  Widget initChat() => ListView(
        children: [
          textField('Digite uma instrução especifica', _instructionController,
              maxLength: 30),
          textField(
              'Digite o conteúdo ou contexto da instrução', _contentController,
              maxLength: 200, maxLines: 3),
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
                        valueListenable: _instructionController,
                        builder: (context, value, child) => 
                            value.text.isEmpty ? const SizedBox() :
                            Text(
                            '${value.text}: ',
                            style: AppTextStyles.labelStyleMedium
                                .copyWith(fontWeight: FontWeight.w500))),
                    ValueListenableBuilder(
                        valueListenable: _contentController,
                        builder: (context, value, child) => 
                          value.text.isEmpty ? const SizedBox() : Text(
                            
                            '${value.text}.',
                            style: AppTextStyles.labelStyleMedium.copyWith(
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.italic))),
                  ]),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              negativeActionButton('Cancelar', () {}),
              positiveActionButton('Iniciar conversa', () async {
                final messages = [
                  NewTextMessageModel(
                      sender: MessageSender.user, text: "${_instructionController.text}: ${_contentController.text}" )
                ];

                await context.read<ChatProvider>().saveChat(Chat(
                    id: widget.registry.id,
                    contentName: widget.registry.contentName,
                    contentType: widget.registry.contentType,
                    topic: widget.registry.topic,
                    dateTime: widget.registry.dateTime,
                    description: widget.registry.description,
                    group: widget.registry.group,
                    contentData: messages));

                _textMessageController.generateAnswer(messages);
              }),
            ],
          )
        ],
      );

  Widget loadedChat() => StreamBuilder<List<TextMessage>>(
      stream: _textMessageController.onNewMessage,
      builder: (context, snapshot) => snapshot.data != null
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) =>
                  switch (snapshot.data![index].sender) {
                    MessageSender.ia => iaText(snapshot.data![index]),
                    MessageSender.user => userText(snapshot.data![index]),
                  })
          : const SizedBox());

  Widget _markdownWidget(String text) => Markdown(
      shrinkWrap: true,
      selectable: true,
      physics: const NeverScrollableScrollPhysics(),
      styleSheet: MarkdownStyleSheet(
        textAlign: WrapAlignment.start,
        p: AppTextStyles.labelStyleSmall,
        h1Align: WrapAlignment.center,
        codeblockPadding: const EdgeInsets.all(15),
        code: AppTextStyles.labelStyleSmall,
        codeblockDecoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            color: Colors.black),
        strong: AppTextStyles.labelStyleMedium,
        h1: AppTextStyles.labelStyleLarge,
        h2: AppTextStyles.labelStyleMedium,
      ),
      data: text);

  Widget iaText(TextMessage message) => Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Stack(
          alignment: Alignment.topLeft,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 15, top: 15),
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(1),
                      topRight: Radius.circular(25),
                      bottomLeft: Radius.circular(1),
                      bottomRight: Radius.circular(5)),
                  color: AppColors.primaryColorDark),
              child: _markdownWidget(message.text)
                  .animate()
                  .moveX(begin: -200, end: 0),
            ),
            Container(
              color: AppColors.secundaryColor,
              margin: const EdgeInsets.only(bottom: 5),
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(message.sender.value),
            )
          ],
        ),
      );

  Widget userText(TextMessage message) => Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 15, top: 15),
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(1),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(5)),
                  color: AppColors.primaryColor),
              child: _markdownWidget(message.text)
                  .animate()
                  .moveX(begin: -200, end: 0),
            ),
            Container(
              color: AppColors.secundaryColor,
              margin: const EdgeInsets.only(bottom: 5),
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(message.sender.value),
            )
          ],
        ),
      ).animate().moveX(begin: 200, end: 0);

  Widget chatWidget() => Expanded(
        child: Selector<ChatProvider, ChatProviderStatus>(
            selector: (context, provider) => provider.status,
            builder: (context, status, child) => switch (status) {
                  ChatProviderStatus.initial => initChat(),
                  ChatProviderStatus.loading => loadingChat(),
                  ChatProviderStatus.loaded => loadedChat(),
                  ChatProviderStatus.notFound => const SizedBox()
                }),
      );

  Widget chatField(IconData icon, String title, String furtherInfo) =>
      Container(
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            border: const Border(
                top: BorderSide(width: 1, color: AppColors.primaryColorDark)),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(25),
            ),
            boxShadow: [
              BoxShadow(
                  blurRadius: 1,
                  spreadRadius: 0,
                  color: Colors.black.withAlpha(100),
                  offset: const Offset(1, 1))
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: Container(
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(),
                ),
                child: TextField(
                  controller: TextEditingController(),
                  style: AppTextStyles.titleStyleSmall,
                  maxLines: 3,
                  maxLength: 50,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintStyle: AppTextStyles.titleStyleSmall,
                      hintText: 'Digite algo...',
                      contentPadding: EdgeInsets.all(15)),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(0),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      bottomRight: Radius.circular(25)),
                  gradient: AppGradients.positiveActionColors),
              height: 50,
              width: 100,
              child: const Text(
                'Enviar',
                style: AppTextStyles.labelStyleSmall,
                softWrap: true,
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Container(
        margin: const EdgeInsets.only(left: 5, right: 5, top: 15),
        decoration: const BoxDecoration(gradient: AppGradients.primaryColors),
        child: Column(
          children: [
            titleContainer(
              widget.registry.topic,
              backAction: () {
                Navigator.pop(context);
              },
            ),
            chatWidget(),
            // chatField(Icons.circle, 'a', 'a'),
          ],
        ),
      ),
    );
  }
}
