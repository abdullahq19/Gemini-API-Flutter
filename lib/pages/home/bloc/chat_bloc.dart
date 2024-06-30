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
    on<ChatInputSubmitEvent>(_onChatInputSubmittedEventHandler);
  }

  List<Content> contents = [];
  bool isGenerating =
      false; // boolean denoting if a user response is being processed
  static const String errorMessage = 'Something went wrong'; // Error Message

  // controller for TextField
  final TextEditingController messageController = TextEditingController();
  // scroll controller for ListView
  final ScrollController messageListScrollController = ScrollController();

  // Submit message event handler
  FutureOr<void> _onChatInputSubmittedEventHandler(
      ChatInputSubmitEvent event, Emitter<ChatState> emit) async {
    try {
      if (messageController.text.isNotEmpty) {
        addUserResponse(emit);
        await getModelResponse(emit);
      }
    } catch (e) {
      emit(ChatErrorState(errorMessage: errorMessage));
      log(e.toString());
    }
  }

  // method to scroll down automatically on every response added
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

  // Adding a response from user
  void addUserResponse(Emitter<ChatState> emit) {
    contents.add(
        Content(role: 'user', parts: [Part(text: messageController.text)]));
    emit(ChatLoadedState(contents: contents));
    messageController.clear();
    isGenerating = true;
    _scrollDown();
  }

  // Getting a response from the model
  Future<void> getModelResponse(Emitter<ChatState> emit) async {
    var contentResponse = await ChatRepository.getGeminiResponse(contents);
    contents.add(contentResponse);
    emit(ChatLoadedState(contents: contents));
    isGenerating = false;
    _scrollDown();
  }
}
