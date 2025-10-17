import 'package:flutter/material.dart';

class NotesCard extends StatelessWidget {
  final Map<String, dynamic> note;
  final Function onDelete;
  final Function onEdit;
  final List<Color> noteColors;

  const NotesCard({
    super.key,
    required this.note,
    required this.onDelete,
    required this.onEdit,
    required this.noteColors,
  });

  @override
  Widget build(BuildContext context) {
    final colorIndex = note['color'] as int;
    return GestureDetector(
      onTap: () => onEdit(),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: noteColors[colorIndex],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note['date'],
              style: const TextStyle(color: Colors.black, fontSize: 12),
            ),

            SizedBox(height: 10),

            Text(
              note['title'],
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: 10),

            Expanded(
              child: Text(
                note['description'],
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  height: 1.5,
                ),
                overflow: TextOverflow.fade,
              ),
            ),

            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => onDelete(),
                    icon: const Icon(Icons.delete_outline, color: Colors.black, size: 20),
                  )
                ]
            ),
          ],
        ),
      ),
    );
  }
}
