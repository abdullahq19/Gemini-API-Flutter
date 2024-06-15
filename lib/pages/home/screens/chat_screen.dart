import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gemini_api_vanilla/pages/home/bloc/chat_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 24, 31, 44),
        title: Text('Chat Jee Pee Tea',
            style: GoogleFonts.montserrat(
                color: Colors.blueGrey.shade100,
                fontWeight: FontWeight.bold,
                fontSize: 30)),
        actions: [
          Padding(
            padding: EdgeInsets.only(
                right: MediaQuery.of(context).size.width * 0.03),
            child: Icon(Icons.chat, color: Colors.blueGrey.shade100),
          )
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 24, 31, 44),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
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
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.03),
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
                                          backgroundColor:
                                              Colors.grey.shade900),
                                      codeblockDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
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
            ),
            Expanded(
              flex: 15,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.03,
                    vertical: 5),
                child: TextField(
                    style: GoogleFonts.montserrat(),
                    autocorrect: true,
                    cursorColor: Colors.blueGrey.shade900,
                    enableSuggestions: true,
                    controller: context.read<ChatBloc>().messageController,
                    decoration: InputDecoration(
                        hintText: 'Ask Anything',
                        fillColor: const Color.fromARGB(255, 175, 203, 255),
                        filled: true,
                        hintStyle: GoogleFonts.montserrat(
                            textStyle: TextStyle(color: Colors.grey.shade800)),
                        suffixIcon: Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.width * 0.03),
                          child: context.watch<ChatBloc>().isGenerating
                              ? Expanded(
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.062,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Lottie.asset(
                                          'assets/images/loader.json',
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                )
                              : InkWell(
                                  splashColor: Colors.white,
                                  onTap: () {
                                    context
                                        .read<ChatBloc>()
                                        .add(ChatInputSubmitEvent());
                                  },
                                  child: CircleAvatar(
                                    backgroundColor: Colors.blueGrey.shade900,
                                    radius: MediaQuery.of(context).size.width *
                                        0.055,
                                    child: Icon(
                                      Icons.send,
                                      color: Colors.blueGrey.shade100,
                                    ),
                                  ),
                                ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
