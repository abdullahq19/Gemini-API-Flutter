part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class ChatInputSubmitEvent extends ChatEvent{}
