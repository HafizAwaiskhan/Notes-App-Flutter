import 'dart:convert';
import '../models/memes_model.dart';
import 'package:http/http.dart' as http;

class MemeService {

  static const _apiUrl = "https://meme-api.com/gimme/wholesomememes/30";

  Future<List<Meme>> fetchMemes() async {
    final url = Uri.parse(_apiUrl);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonBody = json.decode(response.body);

        final List<dynamic> memesJson = jsonBody['memes'] as List<dynamic>;

        return memesJson.map((json) => Meme.fromJson(json)).toList();

      } else {
        // Throw an exception for bad status codes (404, 500, etc.)
        throw Exception("API call failed with status code: ${response.statusCode}");
      }
    } on http.ClientException {
      // Catch specific networking issues (e.g., no internet connection)
      throw Exception("Could not connect to the API. Check your internet connection.");
    } catch (e) {
      // Catch all other unexpected errors (like parsing issues)
      throw Exception("An unexpected error occurred during fetching: $e");
    }
  }
}