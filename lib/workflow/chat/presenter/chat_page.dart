import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:get_it/get_it.dart';
import 'package:plain_registry_app/core/common/text_input/text_input_validator.dart';
import 'package:plain_registry_app/core/common/text_input/text_input_builder.dart';
import 'package:plain_registry_app/core/helpers/formatters/datetime_formatters.dart';
import 'package:plain_registry_app/core/theme/app_colors.dart';
import 'package:plain_registry_app/core/theme/app_gradients.dart';
import 'package:plain_registry_app/core/theme/app_text_styles.dart';
import 'package:plain_registry_app/core/widgets/common/common_widgets.dart';
import 'package:plain_registry_app/workflow/chat/domain/models/chat.dart';
import 'package:plain_registry_app/workflow/chat/domain/models/text_message.dart';
import 'package:plain_registry_app/workflow/chat/presenter/chat_provider.dart';
import 'package:plain_registry_app/workflow/chat/presenter/text_message_provider.dart';
import 'package:plain_registry_app/workflow/home/domain/models/registry_model.dart';
import 'package:provider/provider.dart';

part 'widgets/init_chat_widgets.dart';
part 'widgets/loaded_chat_widget.dart';

class ChatPage extends StatefulWidget {
  final RegistryModel registry;

  const ChatPage({super.key, required this.registry});

  @override
  State<StatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with CommonWidgets {
  final _textMessageController = TextMessageController(GetIt.I.get());

  late final StreamSubscription<List<TextMessage>> _textMessageSubscription;

  @override
  initState() {
    _initChat();
    super.initState();
  }

  void _initChat() {
    listenToGeneratedMessage();
    
    if (widget.registry.hasId) {
      context.read<ChatProvider>().loadChat(widget.registry.id!);
    }

    
  }

  @override
  dispose() {
    _textMessageController.dispose();
    _textMessageSubscription.cancel();
    super.dispose();
  }

  void listenToGeneratedMessage() {
    try {
      _textMessageSubscription =
          _textMessageController.onNewMessage.listen((data) {
        if (mounted) {
          print('SALVEEEE');

          switch(context.read<ChatProvider>().status){
            case ChatProviderStatus.init:
              context.read<ChatProvider>().saveChat(Chat(
                  id: widget.registry.id,
                  contentName: widget.registry.contentName,
                  contentType: widget.registry.contentType,
                  topic: widget.registry.topic,
                  dateTime: widget.registry.dateTime,
                  description: widget.registry.description,
                  group: widget.registry.group,
                  contentData: data));
              break;
            case ChatProviderStatus.loaded:
              context.read<ChatProvider>().saveMessages(data);
              break;
            default: break;
          }

          
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Widget loading() => const Center(child: CircularProgressIndicator());

  Widget failed() => const Center(
        child: Text(
          'Não foi possível iniciar o chat.',
          style: AppTextStyles.labelStyleMedium,
        ),
      );

  Widget init() => InitChatWidget(
        registry: widget.registry,
        textMessageController: _textMessageController,
      );

  Widget loaded() => Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: LoadedChatWidget(
          textMessageController: _textMessageController,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        centerTitle: true,
        title: Text(widget.registry.description),
      ),
      persistentFooterAlignment: AlignmentDirectional.center,
      body: Container(
        decoration: const BoxDecoration(color: AppColors.primaryColorLight),
        child: Selector<ChatProvider, ChatProviderStatus>(
            selector: (context, provider) => provider.status,
            builder: (context, status, child) => switch (status) {
                  ChatProviderStatus.init => init(),
                  ChatProviderStatus.loading => loading(),
                  ChatProviderStatus.loaded => loaded(),
                  ChatProviderStatus.failed => failed(),
                }),
      ),
    );
  }
}
