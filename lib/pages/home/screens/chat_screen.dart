import 'package:flutter/material.dart';
import 'package:gemini_api_vanilla/pages/home/widgets/chat_messages_list.dart';
import 'package:gemini_api_vanilla/pages/home/widgets/chat_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 24, 31, 44),
        title: Text('Hanashi',
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
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 88,child: ChatMessagesList()),
            Expanded(flex: 12,child: ChatTextField()),
          ],
        ),
      ),
    );
  }
}
