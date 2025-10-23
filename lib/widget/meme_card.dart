import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:path/path.dart';

class MemeCard extends StatefulWidget {
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
  State<MemeCard> createState() => _MemeCard();
}

class _MemeCard extends State<MemeCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(height: 10),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              widget.description,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),

          const SizedBox(height: 20),

          CachedNetworkImage(imageUrl: widget.imageUrl,
          placeholder: (context , url) => Center(child: CircularProgressIndicator()),
          errorWidget: (context , url , error) => Icon(Icons.error),
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),

          const SizedBox(height: 20)


        ],
      ),
    );
  }
}
