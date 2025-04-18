import 'dart:io';
import 'package:flutter/material.dart';
import '../model/Note.dart';
import 'EditNoteScreen.dart';
import '../db/NoteAPIService.dart';

// Màn hình chi tiết ghi chú
class NoteDetailScreen extends StatefulWidget {
  final Note note; // Ghi chú được truyền vào

  const NoteDetailScreen({Key? key, required this.note}) : super(key: key);

  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

// State của NoteDetailScreen
class _NoteDetailScreenState extends State<NoteDetailScreen> {
  late Note note; // Ghi chú hiện tại được hiển thị

  @override
  void initState() {
    super.initState();
    note = widget.note; // Gán note từ widget vào state
  }

  // Hàm làm mới ghi chú từ database (sau khi chỉnh sửa)
  Future<void> _refreshNote() async {
    if (note.id == null) {
      print('Note ID is null, cannot refresh');
      return;
    }

    // Lấy ghi chú mới nhất từ database
    final refreshed = await NoteAPIService.instance.getNoteById(note.id!);
    if (refreshed != null) {
      setState(() {
        note = refreshed; // Cập nhật lại note hiển thị
      });
    } else {
      // Nếu note bị xoá, thoát khỏi màn hình
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Màu nền nhẹ
      appBar: AppBar(
        title: Text('Chi tiết Ghi chú'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit), // Nút chỉnh sửa
            onPressed: () async {
              // Chuyển sang màn hình EditNoteScreen
              final isUpdated = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditNoteScreen(note: note),
                ),
              );

              // Nếu có chỉnh sửa xong quay lại, làm mới ghi chú
              if (isUpdated == true) {
                await _refreshNote(); // Lấy bản mới từ database
                Navigator.pop(context, true); // Quay lại màn trước kèm thông báo đã cập nhật
              }
            },
          ),
        ],
      ),

      // Nội dung chi tiết ghi chú
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding toàn màn
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tiêu đề
            Text(
              note.title,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Tiêu đề nội dung
            Text('Nội dung:',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
            SizedBox(height: 5),

            // Nội dung chi tiết
            Text(note.content),
            SizedBox(height: 20),

            // Thời gian tạo và cập nhật
            Text('Thời gian tạo: ${note.createdAt}'),
            Text('Thời gian cập nhật: ${note.modifiedAt}'),
          ],
        ),
      ),
    );
  }
}
