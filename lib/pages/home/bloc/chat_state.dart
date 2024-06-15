part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatIntialState extends ChatState{}

final class ChatLoadedState extends ChatState {
  final List<Content> contents;

  ChatLoadedState({required this.contents});
}

final class ChatErrorState extends ChatState {
  final String errorMessage;

  ChatErrorState({required this.errorMessage});
}
