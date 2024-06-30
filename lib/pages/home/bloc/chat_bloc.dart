import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_api_vanilla/pages/home/models/content.dart';
import 'package:gemini_api_vanilla/pages/home/models/part.dart';
import 'package:gemini_api_vanilla/pages/home/repository/chat_repository.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatIntialState()) {
    on<ChatInputSubmitEvent>(_onChatInputSubmittedEvent);
  }

  List<Content> contents = [];
  bool isGenerating = false;
  static const String errorMessage = 'Something went wrong';

  final TextEditingController messageController = TextEditingController();
  final ScrollController messageListScrollController = ScrollController();

  Future<void> _scrollDown() async {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        if (messageListScrollController.positions.isNotEmpty) {
          await messageListScrollController.animateTo(
              messageListScrollController.position.maxScrollExtent,
              duration: const Duration(seconds: 1),
              curve: Curves.easeInOut);
        }
      },
    );
  }

  FutureOr<void> _onChatInputSubmittedEvent(
      ChatInputSubmitEvent event, Emitter<ChatState> emit) async {
    try {
      if (messageController.text.isNotEmpty) {
        contents.add(
            Content(role: 'user', parts: [Part(text: messageController.text)]));
        emit(ChatLoadedState(contents: contents));
        messageController.clear();
        isGenerating = true;
        _scrollDown();

        var contentResponse = await ChatRepository.getGeminiResponse(contents);
        log(contentResponse.toString());
        contents.add(contentResponse);
        emit(ChatLoadedState(contents: contents));

        isGenerating = false;
        _scrollDown();
      }
    } catch (e) {
      emit(ChatErrorState(errorMessage: errorMessage));
      log(e.toString());
    }
  }
}
