import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_gradients.dart';
import 'package:plain_registry_app/core/theme/app_text_styles.dart';
import 'package:plain_registry_app/core/widgets/common/common_widgets.dart';
import 'package:plain_registry_app/workflow/home/presenter/pages/chat/chat_provider.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<StatefulWidget> createState() => _ChatPageState();
}

enum MessageSender {
  ia('ia'),
  user('user');

  const MessageSender(this.value);

  final String value;
}

class Chat extends Equatable {
  final int id;
  final List<TextMessage> messages;

  const Chat(this.id, this.messages);

  @override
  List<Object?> get props => [id];
}

class TextMessage extends Equatable {
  final int id;
  final int? replyToMessageId;
  final MessageSender sender;
  final String text;

  const TextMessage(
      {required this.id,
      required this.replyToMessageId,
      required this.sender,
      required this.text});

  @override
  List<Object?> get props => [id];
}

class _ChatPageState extends State<ChatPage> with CommonWidgets {
  final List<TextMessage> messages = [
    const TextMessage(
        id: 1,
        replyToMessageId: null,
        sender: MessageSender.user,
        text: 'Fale algo sobre sorvete'),
    const TextMessage(
        id: 2,
        replyToMessageId: 1,
        sender: MessageSender.ia,
        text: 'Sorvete é bom demais'),
  ];

  Widget iaText(TextMessage message) => Stack(
        children: [
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                    color: AppColors.secundaryColor,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(1, 2),
                        blurRadius: 1,
                        color: AppColors.greenLight,
                      )
                    ],
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(25))),
                margin: const EdgeInsets.only(right: 15, top: 15),
                padding: const EdgeInsets.all(15),
                child: Text(message.text),
              ),
              const SizedBox(),
            ],
          ),
          Container(
              padding: const EdgeInsets.only(left: 15, right: 15),
              color: AppColors.greenLight,
              child: Text(message.sender.value)),
        ],
      ).animate().moveX(begin: -200, end: 0);

  Widget userText(TextMessage message) => Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Row(
              children: [
                const SizedBox(),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: AppColors.secundaryColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(50),
                              bottomLeft: Radius.circular(25)),
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(-1, 2),
                                blurRadius: 2,
                                color: AppColors.primaryColorLight),
                          ]),
                      padding: const EdgeInsets.all(15),
                      margin: const EdgeInsets.only(left: 15, top: 15),
                      child: Text(message.text),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              color: AppColors.primaryColorLight,
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text(message.sender.value),
            )
          ],
        ).animate().moveX(begin: 200, end: 0),
      );

  Widget chatWidget() => Container(
      padding: const EdgeInsets.all(0),
      decoration: const BoxDecoration(color: AppColors.backgroundColor),
      alignment: Alignment.center,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, index) => switch (messages[index].sender) {
            MessageSender.ia => iaText(messages[index]),
            MessageSender.user => userText(messages[index]),
          },
        ),
      ));

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
                'enviar',
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
      backgroundColor: AppColors.primaryColor,
      body: Container(
        margin: const EdgeInsets.only(left: 5, right: 5, top: 15),
        child: Column(
          children: [
            titleContainer(
              'Novo chat',
              backAction: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: Consumer<ChatProvider>(
                builder: (context, value, child) => Container(
                  color: AppColors.primaryColorDark,
                  child: Markdown(
                      controller: ScrollController(),
                      selectable: true,
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
                      data: value.data),
                ),
              ),
            ),
            // Expanded(child: chatWidget()),
            chatField(Icons.circle, 'a', 'a')
          ],
        ),
      ),
    );
  }
}
