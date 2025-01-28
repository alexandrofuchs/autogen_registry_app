import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:plain_registry_app/core/external/gemini_api.dart';
import 'package:plain_registry_app/workflow/chat/domain/i_repositories/i_chat_repository.dart';
import 'package:plain_registry_app/workflow/chat/domain/i_services/i_text_message_service.dart';
import 'package:plain_registry_app/workflow/chat/external/repository/chat_repository.dart';
import 'package:plain_registry_app/workflow/chat/external/service/text_message_service.dart';
import 'package:plain_registry_app/workflow/chat/presenter/chat_page.dart';
import 'package:plain_registry_app/workflow/chat/presenter/chat_provider.dart';
import 'package:plain_registry_app/workflow/home/domain/models/registry_model.dart';
import 'package:provider/provider.dart';

abstract class ChatWorkflow {
  static void register() {
    GetIt.I.registerSingleton<GeminiApi>(GeminiApi.instance);
    GetIt.I.registerLazySingleton<ITextMessageService>(() => TextMessageService(GetIt.I.get()));
    GetIt.I.registerLazySingleton<IChatRepository>(() => ChatRepository(GetIt.I.get()));
  }

  static Widget chatPage(RegistryModel model) =>
    ChangeNotifierProvider<ChatProvider>(create:(context) => ChatProvider(GetIt.I.get()),
    child: ChatPage(registry: model),
    );
}
