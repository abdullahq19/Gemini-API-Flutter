import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_api_vanilla/pages/home/bloc/chat_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class ChatTextField extends StatelessWidget {
  const ChatTextField({super.key});

  static const String inputFieldHintText = 'Ask Anything';
  static const String loaderAssetPath = 'assets/images/loader.json';

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    double sendMessageButtonRadius = height * width / 13412;
    double sendMessageButtonIconSize = sendMessageButtonRadius * 0.8;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.03, vertical: height * 0.01),
      child: TextField(
          style: GoogleFonts.montserrat(),
          autocorrect: true,
          cursorColor: Colors.blueGrey.shade900,
          enableSuggestions: true,
          controller: context.read<ChatBloc>().messageController,
          decoration: InputDecoration(
              hintText: inputFieldHintText,
              fillColor: const Color.fromARGB(255, 175, 203, 255),
              filled: true,
              hintStyle: GoogleFonts.montserrat(
                  textStyle: TextStyle(color: Colors.grey.shade800)),
              suffixIcon: Padding(
                padding: EdgeInsets.all(width * 0.03),
                child: context.watch<ChatBloc>().isGenerating
                    ? SizedBox(
                        height: height * 0.062,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child:
                              Lottie.asset(loaderAssetPath, fit: BoxFit.cover),
                        ),
                      )
                    : InkWell(
                        splashColor: Colors.black,
                        onTap: () {
                          context.read<ChatBloc>().add(ChatInputSubmitEvent());
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.blueGrey.shade900,
                          radius: sendMessageButtonRadius,
                          child: Icon(
                            Icons.send,
                            color: Colors.blueGrey.shade100,
                            size: sendMessageButtonIconSize,
                          ),
                        ),
                      ),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(width * 0.04)))),
    );
  }
}
