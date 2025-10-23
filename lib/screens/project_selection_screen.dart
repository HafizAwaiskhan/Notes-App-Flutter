import 'package:flutter/material.dart';

import 'memes/memes_home_page.dart';
import 'notes/notes_home_page.dart';

class ProjectSelectionScreen extends StatelessWidget {
  const ProjectSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Concept Projects",
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, Colors.lightBlueAccent],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              // 1. NOTES APP CARD (Database Concept)
              _buildProjectCard(
                context,
                title: "Notes App",
                description:
                "It's a note app that stores notes locally using Data base. Data base concepts will be clear.",
                concept: "Main Data Base Concept",
                icon: Icons.notes_rounded,
                targetScreen: const NotesHomePage(),
                color: Colors.purple.shade400,
              ),

              const SizedBox(height: 30),

              // 2. MEMES APP CARD (API Concept)
              _buildProjectCard(
                context,
                title: "Memes App",
                description:
                "It's a Meme app that fetches the memes from a remote API and implements layered architecture.",
                concept: "Main API Concept",
                icon: Icons.image_search_rounded,
                targetScreen: const MemesHomePage(),
                color: Colors.indigo.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectCard(
      BuildContext context, {
        required String title,
        required String description,
        required String concept,
        required IconData icon,
        required Widget targetScreen,
        required Color color,
      }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => targetScreen),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color.withOpacity(0.95),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 40, color: Colors.white),
                const SizedBox(width: 15),
                // Project Title
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

            // Concept Title (Bolded Description)
            Text(
              concept,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.amberAccent,
                letterSpacing: 0.5,
              ),
            ),
            const SizedBox(height: 8),

            // Description
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.9),
                height: 1.4,
              ),
            ),

            const SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              child: Icon(Icons.arrow_forward_ios, size: 18, color: Colors.white.withOpacity(0.7)),
            )
          ],
        ),
      ),
    );
  }
}