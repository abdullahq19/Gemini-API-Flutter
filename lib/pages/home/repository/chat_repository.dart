import 'dart:convert';
import 'dart:developer';
import 'package:gemini_api_vanilla/consts.dart';
import 'package:gemini_api_vanilla/pages/home/models/content.dart';
import 'package:http/http.dart' as http;

class ChatRepository {
  static Future<String> onChatInputSubmittedRequest(
      List<Content> contents) async {
    try {
      var response = await http.post(
        Uri.parse(
            'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$GOOGLE_API_KEY'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "contents": contents.map((e) => e.toMap()).toList(),
          "safetySettings": [
            {
              "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
              "threshold": "BLOCK_ONLY_HIGH"
            }
          ],
          "generationConfig": {
            "stopSequences": ["Title"],
            "temperature": 1.0,
            "maxOutputTokens": 2048,
            "topP": 0.8,
            "topK": 10
          }
        }),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> map = jsonDecode(response.body);
        return map['candidates'][0]['content']['parts'][0]['text'];
      }
      return '';
    } catch (e) {
      log(e.toString());
      return '';
    }
  }
}
