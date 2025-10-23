import 'package:flutter/material.dart';

class MemeCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final int ups;
  final String postLink;
  final String author;

  const MemeCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.ups,
    required this.postLink,
    required this.author,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12.0),
      elevation: 6.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            // Use Image.network or a better image widget here
            Image.network(
              imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
              const Center(child: Text('Image failed to load')),
            ),
            const SizedBox(height: 8),
            Text('Author: $author',
                style: const TextStyle(color: Colors.grey)),
            Text('Upvotes: $ups',
                style: const TextStyle(color: Colors.green)),
          ],
        ),
      ),
    );
  }
}