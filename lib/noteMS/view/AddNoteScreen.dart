import 'package:flutter/material.dart';
import '../model/Note.dart';
import '../db/NoteAPIService.dart';

// Widget màn hình thêm ghi chú, là một StatefulWidget vì có thay đổi trạng thái
class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

// State của AddNoteScreen
class _AddNoteScreenState extends State<AddNoteScreen> {
  // Controller để lấy dữ liệu từ TextField nhập tiêu đề và nội dung
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  // Mức độ ưu tiên mặc định là 3 (Thấp)
  int _priority = 3;

  // Hàm lưu ghi chú vào database
  Future<void> _saveNote() async {
    // Chỉ lưu khi người dùng đã nhập cả tiêu đề và nội dung
    if (_titleController.text.isNotEmpty && _contentController.text.isNotEmpty) {
      // Tạo một đối tượng Note mới từ dữ liệu người dùng nhập
      Note newNote = Note(
        id: null, // ID để null để database tự sinh
        title: _titleController.text,
        content: _contentController.text,
        priority: _priority,
        createdAt: DateTime.now(), // Thời gian tạo hiện tại
        modifiedAt: DateTime.now(), // Thời gian sửa lần đầu cũng là hiện tại
        tags: [], // Tạm thời chưa có tag
        color: "#FFFFFF", // Màu mặc định là trắng
      );

      // Gọi hàm insert từ DatabaseHelper để lưu vào SQLite
      await NoteAPIService.instance.createNote(newNote);

      // Quay lại màn hình trước sau khi lưu xong
      Navigator.pop(context);
    }
  }

  // Giao diện chính của màn hình
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thêm Ghi chú'), // Tiêu đề trên thanh AppBar
        actions: [
          IconButton(
            icon: Icon(Icons.save), // Nút lưu với icon hình đĩa mềm
            onPressed: _saveNote, // Gọi hàm lưu khi nhấn nút
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding toàn phần cho body
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ô nhập tiêu đề
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Tiêu đề'),
            ),
            SizedBox(height: 10),
            // Ô nhập nội dung ghi chú (đa dòng)
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Nội dung'),
              maxLines: 5, // Tối đa 5 dòng
            ),
            SizedBox(height: 10),
            // Dropdown chọn mức độ ưu tiên
            DropdownButton<int>(
              value: _priority, // Giá trị hiện tại
              onChanged: (int? newValue) {
                // Khi người dùng chọn, cập nhật lại state
                setState(() {
                  _priority = newValue ?? 3; // Nếu null thì vẫn giữ 3
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