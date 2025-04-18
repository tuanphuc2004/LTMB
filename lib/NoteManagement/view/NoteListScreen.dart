import "../model/Note.dart";
import '../view/NoteListItem.dart';
import "../db/NoteDatabaseHelper.dart";
import "../view/AddNoteScreen.dart";
import "../view/EditNoteScreen.dart";
import '../view/NoteDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteListScreen extends StatefulWidget {
  @override
  _NoteListScreenState createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  late Future<List<Note>> _notesFuture;
  bool isGridView = false;
  final TextEditingController searchController = TextEditingController();
  final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm:ss');

  @override
  void initState() {
    super.initState();
    _refreshNotes();
  }

  Future<void> _refreshNotes() async {
    setState(() {
      _notesFuture = NoteDatabaseHelper.instance.getNotesByPriority();
    });
  }

  void _toggleView() {
    setState(() {
      isGridView = !isGridView;
    });
  }

  void _searchNotes(String query) async {
    if (query.isEmpty) {
      _refreshNotes();
      return;
    }
    setState(() {
      _notesFuture = NoteDatabaseHelper.instance.searchNotes(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách Ghi chú'),
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: _refreshNotes),
          IconButton(
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
            onPressed: _toggleView,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Tìm kiếm ghi chú',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _searchNotes,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Note>>(
              future: _notesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Đã xảy ra lỗi: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Không có ghi chú nào'));
                } else if (isGridView) {
                  return _buildGridView(snapshot.data!);
                } else {
                  return _buildListView(snapshot.data!);
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNoteScreen()),
          );
          _refreshNotes(); // Reload the notes after adding a new one
        },
      ),
    );
  }

  Widget _buildListView(List<Note> notes) {
    return ListView.separated( // Thay ListView.builder bằng ListView.separated
      itemCount: notes.length,
      separatorBuilder: (context, index) => SizedBox(height: 8), // Thêm khoảng cách giữa các item
      itemBuilder: (context, index) {
        final note = notes[index];
        return Card( // Bọc ListTile trong Card
          margin: EdgeInsets.symmetric(horizontal: 8), // Khoảng cách hai bên
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Bo tròn góc
          ),
          color: _getPriorityColor(note.priority),
          child: ListTile(
            title: Text(note.title),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(note.content),
                SizedBox(height: 4),
                Text(
                  'Tạo: ${formatter.format(DateTime.parse(note.createdAt.toString()))}',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
                Text(
                  'Sửa: ${formatter.format(DateTime.parse(note.modifiedAt.toString()))}',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            onTap: () async {
              final updated = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NoteDetailScreen(note: note)),
              );
              if (updated == true) {
                _refreshNotes();
              }
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () async {
                    final updated = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditNoteScreen(note: note)),
                    );
                    if (updated == true) {
                      _refreshNotes();
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await NoteDatabaseHelper.instance.deleteNote(note.id!);
                    _refreshNotes();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildGridView(List<Note> notes) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
      ),
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes[index];
        return GestureDetector(
          onTap: () async {
            final updated = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NoteDetailScreen(note: note),
              ),
            );
            if (updated == true) {
              _refreshNotes(); // Reload after editing
            }
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Bo tròn góc
            ),
            color: _getPriorityColor(note.priority),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    note.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Tạo: ${formatter.format(DateTime.parse(note.createdAt.toString()))}',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    'Sửa: ${formatter.format(DateTime.parse(note.modifiedAt.toString()))}',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

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
}
