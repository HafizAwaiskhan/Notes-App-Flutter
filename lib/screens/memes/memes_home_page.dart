import 'package:flutter/material.dart';
import 'package:notes_app_flutter/models/memes_model.dart';
import 'package:notes_app_flutter/services/memes_service.dart';
import '../../widget/meme_card.dart';

class MemesHomePage extends StatefulWidget {
  const MemesHomePage({super.key});

  @override
  State<MemesHomePage> createState() => _MemesHomePageState();
}

class _MemesHomePageState extends State<MemesHomePage> {
  List<Meme> memes = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMeme();
  }

  Future<void> fetchMeme() async {
    final fetchedMemes = await MemeService.fetchMemes(context);
    if (fetchedMemes != null) {
      setState(() {
        memes = fetchedMemes;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Memes App",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigo, Colors.lightBlueAccent],
          ),
        ),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : memes.isEmpty
            ? Center(child: Text("No memes Found"))
            : ListView.builder(
                itemCount: memes.length,
                itemBuilder: (context, index) {
                  final meme = memes[index];
                  return MemeCard(
                    title: meme.title,
                    description: meme.author,
                    imageUrl: meme.url,
                    ups: meme.ups,
                    postLink: meme.postLink,
                    author: meme.author,
                  );
                },
              ),
      ),
    );
  }
}
