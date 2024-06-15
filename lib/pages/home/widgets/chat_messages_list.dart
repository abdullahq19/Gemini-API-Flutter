import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gemini_api_vanilla/pages/home/bloc/chat_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatMessagesList extends StatelessWidget {
  const ChatMessagesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 85,
      child: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          if (state is ChatIntialState) {
            return Center(
              child: Text(
                'Ask something to start a chat',
                style: GoogleFonts.montserrat(
                    color: Colors.blueGrey.shade100,
                    fontWeight: FontWeight.w500,
                    fontSize: 12),
              ),
            );
          } else if (state is ChatLoadedState) {
            return ListView.builder(
              itemCount: state.contents.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.03),
                    padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width * 0.03),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 175, 203, 255),
                      borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * 0.05),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.contents[index].role.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        MarkdownBody(
                          styleSheet: MarkdownStyleSheet(
                              p: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w500),
                              code: TextStyle(
                                  color: Colors.white,
                                  backgroundColor: Colors.grey.shade900),
                              codeblockDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.grey.shade900)),
                          data: state.contents[index].parts.first.text,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Text((state as ChatErrorState).errorMessage);
          }
        },
      ),
    );
  }
}
