import 'package:flutter/material.dart';
import 'package:notes_app_flutter/screens/notes_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Splash Screen",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            const Icon(Icons.notes_outlined, size: 100, color: Colors.black),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _navigateToNotesScreen();
  }

  _navigateToNotesScreen() async {
    await Future.delayed(Duration(seconds: 3), () {});
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => NotesScreen()),
      );
  }
}
