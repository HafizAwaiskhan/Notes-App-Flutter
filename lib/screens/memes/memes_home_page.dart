import 'package:flutter/material.dart';
import 'package:notes_app_flutter/models/memes_model.dart';
import 'package:notes_app_flutter/services/memes_service.dart';
import '../../repository/memes_repo.dart';
import '../../widget/meme_card.dart';

class MemesHomePage extends StatefulWidget {
  const MemesHomePage({super.key});

  @override
  State<MemesHomePage> createState() => _MemesHomePageState();
}

class _MemesHomePageState extends State<MemesHomePage> {
  // 1. INSTANTIATE DEPENDENCIES
  // The service is the dependency of the repository.
  final MemeService _memeService = MemeService();
  // The UI/State depends only on the repository.
  late final MemeRepository _memeRepository;

  List<Meme> memes = [];
  bool isLoading = true;
  String? errorMessage; // State to hold any error message

  @override
  void initState() {
    super.initState();
    // Initialize the repository using the service
    _memeRepository = MemeRepository(memeService: _memeService);
    fetchMeme();
  }

  Future<void> fetchMeme() async {
    // Ensure we start in a loading state
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      // 2. CALL THE REPOSITORY (The single source of data for the UI)
      final fetchedMemes = await _memeRepository.getMemes();

      setState(() {
        memes = fetchedMemes;
        isLoading = false;
      });
    } catch (e) {
      // Catch the exception thrown by the Repository (which came from the Service)
      setState(() {
        isLoading = false;
        // Store the error message to display in the UI
        errorMessage = "Error loading memes: ${e.toString()}";
      });
      // Optionally, still show a Snackbar for transient feedback
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(errorMessage ?? 'Unknown error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigo, Colors.lightBlueAccent],
          ),
        ),
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              errorMessage!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ));
    }

    if (memes.isEmpty) {
      return const Center(
          child: Text(
            "No memes Found",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ));
    }

    return ListView.builder(
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
    );
  }
}