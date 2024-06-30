import 'dart:developer';

import 'package:gemini_api_vanilla/pages/home/models/content.dart';
import 'package:gemini_api_vanilla/pages/home/services/api_service.dart';

class ChatRepository {
  static Future<Content> getGeminiResponse(List<Content> contents) async {
    try {
      ChatAPIService apiService = ChatAPIService();
      return await apiService.fetchChatResponse(contents);
    } catch (e) {
      log('Repository Exception: ${e.toString()}');
      throw Exception('Repository response failure');
    }
  }
}
