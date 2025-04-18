import 'package:flutter/material.dart';
import '../model/Note.dart';
import '../db/NoteAPIService.dart';

// Widget màn hình chỉnh sửa ghi chú, nhận một ghi chú cần chỉnh sửa
class EditNoteScreen extends StatefulWidget {
  final Note note; // Ghi chú cần chỉnh sửa được truyền vào qua constructor

  const EditNoteScreen({Key? key, required this.note}) : super(key: key);

  @override
  _EditNoteScreen createState() => _EditNoteScreen();
}

// State của EditNoteScreen
class _EditNoteScreen extends State<EditNoteScreen> {
  // Controller để thao tác với ô nhập
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  late int _priority; // Lưu mức độ ưu tiên hiện tại

  // Khởi tạo controller và giá trị ban đầu từ ghi chú được truyền vào
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
    _priority = widget.note.priority;
  }

  // Giải phóng controller khi widget bị huỷ
  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  // Hàm lưu ghi chú đã chỉnh sửa
  Future<void> _saveNote() async {
    // Kiểm tra dữ liệu không trống
    if (_titleController.text.isNotEmpty && _contentController.text.isNotEmpty) {
      // Tạo ghi chú mới từ dữ liệu đã chỉnh sửa
      Note updNote = Note(
        id: widget.note.id, // Dữ nguyên ID cũ để cập nhật
        title: _titleController.text,
        content: _contentController.text,
        priority: _priority,
        createdAt: widget.note.createdAt, // Giữ nguyên thời gian tạo ban đầu
        modifiedAt: DateTime.now(), // Cập nhật thời gian sửa đổi
        tags: [], // Chưa có chức năng tag nên để rỗng
        color: "#FFFFFF", // Màu mặc định
      );

      // Cập nhật ghi chú vào database
      await NoteAPIService.instance.updateNote(updNote);

      // Quay về màn hình trước và trả kết quả true (có cập nhật)
      Navigator.pop(context, true);
    }
  }

  // Giao diện chỉnh sửa ghi chú
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sửa Ghi chú'), // Tiêu đề AppBar
        actions: [
          IconButton(
            icon: Icon(Icons.save), // Nút lưu
            onPressed: _saveNote,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding toàn khung
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ô nhập tiêu đề
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Tiêu đề'),
            ),
            SizedBox(height: 10),
            // Ô nhập nội dung
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Nội dung'),
              maxLines: 5, // Cho phép nhập nhiều dòng
            ),
            SizedBox(height: 10),
            // Dropdown chọn mức độ ưu tiên
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