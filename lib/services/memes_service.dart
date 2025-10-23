import 'package:flutter/material.dart';
import '../models/memes_model.dart';
import 'package:http/http.dart' as http;

class MemeService {

  static Future<List<Meme>?> fetchMemes(BuildContext context) async{
    final url = Uri.parse("https://meme-api.com/gimme/wholesomememes/30");

    try{
      final response = await http.get(url);
      if(response.statusCode == 200) {
        final memesModel = memesModelFromJson(response.body);
        final memes = memesModel.memes;

        return memes;
      } else {
        throw Exception("Failed to load memes");
      }

    } catch (e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to load memes: $e")));
      return null;
    }

  }
}