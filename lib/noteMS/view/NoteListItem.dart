import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import "package:app_02/noteMS/view/NoteDetailScreen.dart";
import '../model/Note.dart';

// Widget hiển thị 1 item trong danh sách ghi chú
class NoteListItem extends StatelessWidget {
  final Note note; // Ghi chú cần hiển thị
  final VoidCallback onEdit; // Hàm callback khi nhấn sửa
  final VoidCallback onDelete; // Hàm callback khi nhấn xoá

  NoteListItem({
    required this.note,
    required this.onEdit,
    required this.onDelete,
  });

  // Hàm trả về màu sắc dựa trên mức độ ưu tiên
  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red.shade100; // Ưu tiên cao
      case 2:
        return Colors.yellow.shade100; // Trung bình
      case 3:
        return Colors.green.shade100; // Thấp
      default:
        return Colors.grey.shade200; // Không xác định
    }
  }

  // Format ngày giờ thành kiểu "dd/MM/yyyy HH:mm:ss"
  final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm:ss');

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _getPriorityColor(note.priority), // Màu nền theo priority
      child: ListTile(
        // Tiêu đề ghi chú
        title: Text(note.title, style: TextStyle(fontWeight: FontWeight.bold)),

        // Nội dung ngắn gọn + thời gian tạo/sửa
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nội dung rút gọn (2 dòng)
            Text(
              note.content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),

            // Thời gian tạo
            Text(
              'Tạo: ${formatter.format(note.createdAt)}',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),

            // Thời gian sửa
            Text(
              'Sửa: ${formatter.format(note.modifiedAt)}',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),

        // Các nút ở bên phải (edit + delete)
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Nút sửa
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
            ),

            // Nút xoá (hiện dialog xác nhận)
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Xác nhận xoá'),
                    content: Text('Bạn có chắc chắn muốn xoá ghi chú này không?'),
                    actions: [
                      TextButton(
                        child: Text('Huỷ'),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                        child: Text('Xoá'),
                        onPressed: () {
                          onDelete(); // Gọi callback xoá
                          Navigator.pop(context); // Đóng dialog
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),

        // Khi nhấn vào ListTile → chuyển sang màn chi tiết
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NoteDetailScreen(note: note),
            ),
          );
        },
      ),
    );
  }
}