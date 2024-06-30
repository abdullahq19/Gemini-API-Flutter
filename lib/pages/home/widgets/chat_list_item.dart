import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gemini_api_vanilla/pages/home/bloc/chat_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatListItem extends StatelessWidget {
  const ChatListItem({super.key, required this.index, required this.state});

  final ChatLoadedState state;
  final int index;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: width * 0.03),
        padding: EdgeInsets.all(width * 0.03),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 175, 203, 255),
          borderRadius: BorderRadius.circular(width * 0.05),
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
                  p: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
                  code: GoogleFonts.sourceCodePro(
                      color: Colors.grey.shade300,
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
  }
}
