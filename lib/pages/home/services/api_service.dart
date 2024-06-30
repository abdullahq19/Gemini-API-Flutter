import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:gemini_api_vanilla/consts.dart';
import 'package:gemini_api_vanilla/pages/home/models/content.dart';
import 'package:http/http.dart';

abstract class ApiService {
  String get _baseUrl => 'https://generativelanguage.googleapis.com';
  String get _apiUrl;
  String get _url => _baseUrl + _apiUrl + GOOGLE_API_KEY;

  fetch(List<Content> contents) async {
    try {
      var response = await post(
        Uri.parse(_url),
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

      if (response.statusCode == HttpStatus.ok) {
        Map<String, dynamic> map = jsonDecode(response.body);
        return map['candidates'][0]['content'];
      }
    } catch (e) {
      log("Post Request Exception: ${e.toString()}");
    }
  }
}

class ChatAPIService extends ApiService {
  @override
  String get _apiUrl => '/v1beta/models/gemini-1.5-flash:generateContent?key=';

  Future<Content> fetchChatResponse(List<Content> contents) async {
    Map<String, dynamic> map = await fetch(contents);
    return Content.fromMap(map);
  }
}
