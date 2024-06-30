import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gemini_api_vanilla/pages/home/bloc/chat_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatListItem extends StatefulWidget {
  const ChatListItem({super.key, required this.index, required this.state});

  final ChatLoadedState state;
  final int index;

  @override
  State<ChatListItem> createState() => _ChatListItemState();
}

class _ChatListItemState extends State<ChatListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1))
          ..forward();
    fadeAnimation =
        Tween<double>(begin: 0.5, end: 1.0).animate(_animationController);
    slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.02), end: Offset.zero)
            .animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SlideTransition(
        position: slideAnimation,
        child: FadeTransition(
          opacity: fadeAnimation,
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
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
                  widget.state.contents[widget.index].role.toUpperCase(),
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
                          backgroundColor: Colors.grey.shade900,
                          fontWeight: FontWeight.w500),
                      codeblockDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(width * 0.04),
                          color: Colors.grey.shade900)),
                  data: widget.state.contents[widget.index].parts.first.text,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
