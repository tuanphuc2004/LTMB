import 'dart:io';
import 'package:flutter/material.dart';
import '../model/Note.dart';
import 'EditNoteScreen.dart';
import '../db/NoteDatabaseHelper.dart';

class NoteDetailScreen extends StatefulWidget {
  final Note note;

  const NoteDetailScreen({Key? key, required this.note}) : super(key: key);

  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late Note note;

  @override
  void initState() {
    super.initState();
    note = widget.note;
  }

  Future<void> _refreshNote() async {
    if (note.id == null) {
      print('Note ID is null, cannot refresh');
      return;
    }

    final refreshed = await NoteDatabaseHelper.instance.getNoteById(note.id!);
    if (refreshed != null) {
      setState(() {
        note = refreshed;
      });
    } else {
      Navigator.pop(context); // Quay lại nếu ghi chú bị xoá
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Chi tiết Ghi chú'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              final isUpdated = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditNoteScreen(note: note),
                ),
              );

              if (isUpdated == true) {
                await _refreshNote();
                Navigator.pop(context, true); // Quay lại và báo là đã cập nhật
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Nội dung:',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
            SizedBox(height: 5),
            Text(note.content),
            SizedBox(height: 20),
            Text('Thời gian tạo: ${note.createdAt}'),
            Text('Thời gian cập nhật: ${note.modifiedAt}'),
          ],
        ),
      ),
    );
  }
}
