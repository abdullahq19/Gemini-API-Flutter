import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_api_vanilla/pages/home/bloc/chat_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 15,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03, vertical: 5),
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
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.03),
                  child: context.watch<ChatBloc>().isGenerating
                      ? Expanded(
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.062,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Lottie.asset('assets/images/loader.json',
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
                            radius: MediaQuery.of(context).size.width * 0.055,
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
    );
  }
}
