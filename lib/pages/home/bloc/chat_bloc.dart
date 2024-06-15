import 'dart:async';
import 'dart:math';
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

  final TextEditingController messageController = TextEditingController();

  FutureOr<void> _onChatInputSubmittedEvent(
      ChatInputSubmitEvent event, Emitter<ChatState> emit) async {
    try {
      if (messageController.text.isNotEmpty) {
        contents.add(
            Content(role: 'user', parts: [Part(text: messageController.text)]));
        emit(ChatLoadedState(contents: contents));
        messageController.clear();
        isGenerating = true;

        String responseText =
            await ChatRepository.onChatInputSubmittedRequest(contents);
        if (responseText.isNotEmpty) {
          contents
              .add(Content(role: 'model', parts: [Part(text: responseText)]));
          emit(ChatLoadedState(contents: contents));
        }
        isGenerating = false;
      }
    } catch (e) {
      emit(ChatErrorState(errorMessage: 'Something went wrong'));
      log(e.toString() as num);
    }
  }
}
