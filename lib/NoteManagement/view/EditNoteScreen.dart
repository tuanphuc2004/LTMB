import 'package:flutter/material.dart';
import '../model/Note.dart';
import '../db/NoteDatabaseHelper.dart';

class EditNoteScreen extends StatefulWidget {
  final Note note;
  const EditNoteScreen({Key? key, required this.note}) : super(key: key);

  @override
  _EditNoteScreen createState() => _EditNoteScreen();
}

class _EditNoteScreen extends State<EditNoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late int _priority; // Mặc định là mức độ ưu tiên thấp

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
    _priority = widget.note.priority;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }


  Future<void> _saveNote() async {
    if (_titleController.text.isNotEmpty && _contentController.text.isNotEmpty) {
      Note updNote = Note(
        id: widget.note.id, // hoặc một giá trị tự động nếu đã thiết lập
        title: _titleController.text,
        content: _contentController.text,
        priority: _priority,
        createdAt: widget.note.createdAt,
        modifiedAt: DateTime.now(),
        tags: [], // Truyền danh sách rỗng nếu không có thẻ
        color: "#FFFFFF", // Hoặc bất kỳ giá trị màu nào mặc định
      );
      await NoteDatabaseHelper.instance.updateNote(updNote);
      Navigator.pop(context, true);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sửa Ghi chú'),
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
