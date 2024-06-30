import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_api_vanilla/pages/home/bloc/chat_bloc.dart';
import 'package:gemini_api_vanilla/pages/home/widgets/chat_list_item.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatMessagesList extends StatelessWidget {
  const ChatMessagesList({super.key});

  static const String initialChatText = 'Ask something to start a chat';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is ChatIntialState) {
          return Center(
            child: Text(
              initialChatText,
              style: GoogleFonts.montserrat(
                  color: Colors.blueGrey.shade100,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
          );
        } else if (state is ChatLoadedState) {
          return ListView.builder(
            itemCount: state.contents.length,
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            controller: context.read<ChatBloc>().messageListScrollController,
            itemBuilder: (context, index) {
              return ChatListItem(index: index, state: state);
            },
          );
        } else {
          return Text((state as ChatErrorState).errorMessage);
        }
      },
    );
  }
}
