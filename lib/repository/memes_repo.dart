import '../models/memes_model.dart';
import 'package:notes_app_flutter/services/memes_service.dart';

class MemeRepository {
  final MemeService _memeService;

  MemeRepository({required MemeService memeService})
      : _memeService = memeService;

  Future<List<Meme>> getMemes() async {
    try {
      final memes = await _memeService.fetchMemes();
      return memes;

    } catch (e) {
      rethrow;
    }
  }
}
