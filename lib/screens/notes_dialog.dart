import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotesDialog extends StatefulWidget {
  final int? noteId;
  final String? title;
  final String? description;
  final int colorIndex;
  final List<Color> noteColors;
  final Function onNoteSaved;

  const NotesDialog({
    super.key,
    this.noteId,
    this.title,
    this.description,
    required this.colorIndex,
    required this.noteColors,
    required this.onNoteSaved,
  });

  @override
  State<NotesDialog> createState() => _NotesDialogState();
}

class _NotesDialogState extends State<NotesDialog> {
  late int _selectedColorIndex;

  @override
  void initState() {
    super.initState();
    _selectedColorIndex = widget.colorIndex;
  }


  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: widget.title);
    final descriptionController = TextEditingController(
      text: widget.description,
    );

    final currentDate = DateFormat("E d MMM").format(DateTime.now());

    return AlertDialog(
      backgroundColor: widget.noteColors[_selectedColorIndex],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        widget.noteId == null ? 'Add Note' : 'Edit Note',
        style: const TextStyle(color: Colors.black),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentDate,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              style: const TextStyle(color: Colors.black, fontSize: 24),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: descriptionController,
              maxLines: 5,
              decoration: const InputDecoration(
                labelText: 'Description',
                filled: true,
                fillColor: Colors.white,
                alignLabelWithHint: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
              style: const TextStyle(color: Colors.black, fontSize: 24),
            ),

            const SizedBox(height: 20),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: List.generate(
                widget.noteColors.length,
                    (index) {
                  final isSelected = _selectedColorIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColorIndex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? Colors.blue.shade700 : Colors.transparent,
                          width: isSelected ? 3.0 : 3.0, // Match widths to prevent shift
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: widget.noteColors[index],
                        child: isSelected
                            ? const Icon(Icons.check, color: Colors.black, size: 16)
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel', style: TextStyle(color: Colors.black)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () async {
            final newTitle = titleController.text;
            final newDescription = descriptionController.text;

            widget.onNoteSaved(
              newTitle,
              newDescription,
              _selectedColorIndex,
              currentDate,
            );
            Navigator.pop(context);
          },
          child: const Text('Save', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
