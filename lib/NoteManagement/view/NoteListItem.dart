import 'dart:io';
import 'package:intl/intl.dart';
import "../db/NoteDatabaseHelper.dart";
import 'package:flutter/material.dart';
import "../view/NoteDetailScreen.dart";
import '../model/Note.dart';

class NoteListItem extends StatelessWidget {
  final Note note;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  NoteListItem({
    required this.note,
    required this.onEdit,
    required this.onDelete,
  });

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red.shade100;
      case 2:
        return Colors.yellow.shade100;
      case 3:
        return Colors.green.shade100;
      default:
        return Colors.grey.shade200;
    }
  }
  final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm:ss');

  @override
  Widget build(BuildContext context) {
    return Card(
      color: _getPriorityColor(note.priority),
      child: ListTile(
        title: Text(note.title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
            Text('Tạo: ${formatter.format(DateTime.parse(note.createdAt.toString()))}', style: TextStyle(fontSize: 12, color: Colors.grey)),
            Text('Sửa: ${formatter.format(DateTime.parse(note.modifiedAt.toString()))}', style: TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: Icon(Icons.edit, color: Colors.blue), onPressed: onEdit),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (context) => AlertDialog(
                        title: Text('Xác nhận xoá'),
                        content: Text(
                          'Bạn có chắc chắn muốn xoá ghi chú này không?',
                        ),
                        actions: [
                          TextButton(
                            child: Text('Huỷ'),
                            onPressed: () => Navigator.pop(context),
                          ),
                          TextButton(
                            child: Text('Xoá'),
                            onPressed: () {
                              onDelete();
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                );
              },
            ),
          ],
        ),
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
