import 'package:flutter/material.dart';
import '../model/Note.dart';
import '../db/NoteDatabaseHelper.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  int _priority = 3; // Mặc định là mức độ ưu tiên thấp

  Future<void> _saveNote() async {
    if (_titleController.text.isNotEmpty && _contentController.text.isNotEmpty) {
      Note newNote = Note(
        id: null, // hoặc một giá trị tự động nếu đã thiết lập
        title: _titleController.text,
        content: _contentController.text,
        priority: _priority,
        createdAt: DateTime.now(),
        modifiedAt: DateTime.now(),
        tags: [], // Truyền danh sách rỗng nếu không có thẻ
        color: "#FFFFFF", // Hoặc bất kỳ giá trị màu nào mặc định
      );
      await NoteDatabaseHelper.instance.insertNote(newNote);
      Navigator.pop(context);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm Ghi chú'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Tiêu đề'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Nội dung'),
              maxLines: 5,
            ),
            SizedBox(height: 10),
            DropdownButton<int>(
              value: _priority,
              onChanged: (int? newValue) {
                setState(() {
                  _priority = newValue ?? 3;
                });
              },
              items: [
                DropdownMenuItem(value: 1, child: Text('Cao')),
                DropdownMenuItem(value: 2, child: Text('Trung bình')),
                DropdownMenuItem(value: 3, child: Text('Thấp')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
