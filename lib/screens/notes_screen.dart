import 'package:flutter/material.dart';
import 'package:notes_app_flutter/database/notes_db.dart';
import 'package:notes_app_flutter/screens/notes_card.dart';

import 'notes_dialog.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Map<String, dynamic>> notes = [];

  @override
  void initState() {
    super.initState();
    fetchNotes();
  }

  Future<void> fetchNotes() async {
    final fetchNotes = await NotesDatabase.instance.getNotes();
    setState(() {
      notes = fetchNotes;
    });
  }

  final List<Color> noteColors = [
    const Color(0xffF28B82),
    const Color(0xffFBC02D),
    const Color(0xffF5F5F5),
    const Color(0xffCCFF90),
    const Color(0xffA7FFEB),
    const Color(0xffCBF0F8),
    const Color(0xffA5C8FF),
    const Color(0xffD7AEFC),
    const Color(0xffFBCFE8),
    const Color(0xffE6C9A8),
    const Color(0xffE8EAED),
    const Color(0xffC5E1A5),
    const Color(0xffFFF3E0),
    const Color(0xffFFE0E0),
  ];

  void showNoteDialog({
    int? id,
    String? title,
    String? description,
    int colorIndex = 0,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return NotesDialog(
          noteId: id,
          title: title,
          description: description,
          colorIndex: colorIndex,
          noteColors: noteColors,
          onNoteSaved:
              (newTitle, newDescription, newColorIndex, currentDate) async {
                if (id == null) {
                  await NotesDatabase.instance.addNote(
                    newTitle,
                    newDescription,
                    currentDate,
                    newColorIndex,
                  );
                } else {
                  await NotesDatabase.instance.updateNote(
                    id,
                    newTitle,
                    newDescription,
                    currentDate,
                    newColorIndex,
                  );
                  fetchNotes();
                }
              },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          "Notes",
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showNoteDialog();
        },
        backgroundColor: Colors.white,
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: notes.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notes_outlined, size: 100, color: Colors.black),
                  const SizedBox(height: 20),

                  Text(
                    "No notes found",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.85,
                ),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final note = notes[index];

                  return NotesCard(
                    note: note,
                    onDelete: () async {
                      await NotesDatabase.instance.deleteNote(note['id']);
                      fetchNotes();
                    },
                    onEdit: () {
                      showNoteDialog(
                        id: note['id'],
                        title: note['title'],
                        description: note['description'],
                        colorIndex: note['color']
                      );
                    },
                    noteColors: noteColors
                    );
                },
              ),
            ),
    );
  }
}
