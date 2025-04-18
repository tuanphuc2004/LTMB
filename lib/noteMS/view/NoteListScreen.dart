import "package:app_02/noteMS/model/Note.dart";
import "../db/NoteAPIService.dart";
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
  late Future<List<Note>> _notesFuture; // Biến để lưu danh sách ghi chú từ database
  bool isGridView = false; // Biến để điều khiển giữa chế độ danh sách và lưới
  final TextEditingController searchController = TextEditingController(); // Controller cho ô tìm kiếm
  final DateFormat formatter = DateFormat('dd/MM/yyyy HH:mm:ss'); // Định dạng thời gian

  @override
  void initState() {
    super.initState();
    _refreshNotes(); // Tải danh sách ghi chú khi màn hình được khởi tạo
  }

  // Hàm tải lại danh sách ghi chú từ database
  Future<void> _refreshNotes() async {
    setState(() {
      _notesFuture = NoteAPIService.instance.getNotesSortedByPriority(); // Lấy ghi chú theo độ ưu tiên
    });
  }

  // Hàm chuyển đổi giữa chế độ ListView và GridView
  void _toggleView() {
    setState(() {
      isGridView = !isGridView;
    });
  }

  // Hàm tìm kiếm ghi chú theo từ khóa
  void _searchNotes(String query) async {
    if (query.isEmpty) {
      _refreshNotes(); // Nếu ô tìm kiếm trống, tải lại tất cả ghi chú
      return;
    }
    setState(() {
      _notesFuture = NoteAPIService.instance.searchNotesByTitle(query); // Lọc ghi chú theo từ khoá
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách Ghi chú'),
        actions: [
          // Nút reload để tải lại danh sách ghi chú
          IconButton(icon: Icon(Icons.refresh), onPressed: _refreshNotes),

          // Nút chuyển đổi giữa chế độ ListView và GridView
          IconButton(
            icon: Icon(isGridView ? Icons.list : Icons.grid_view),
            onPressed: _toggleView,
          ),
        ],
      ),
      body: Column(
        children: [
          // Ô tìm kiếm để lọc ghi chú
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                labelText: 'Tìm kiếm ghi chú',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _searchNotes, // Gọi hàm tìm kiếm khi thay đổi nội dung
            ),
          ),

          // Hiển thị danh sách hoặc lưới ghi chú
          Expanded(
            child: FutureBuilder<List<Note>>(
              future: _notesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator()); // Đang tải dữ liệu
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Đã xảy ra lỗi: ${snapshot.error}'), // Hiển thị lỗi nếu có
                  );
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Không có ghi chú nào')); // Nếu không có ghi chú
                } else if (isGridView) {
                  return _buildGridView(snapshot.data!); // Hiển thị GridView nếu đang ở chế độ này
                } else {
                  return _buildListView(snapshot.data!); // Hiển thị ListView nếu đang ở chế độ này
                }
              },
            ),
          ),
        ],
      ),
      // Nút thêm ghi chú mới
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddNoteScreen()), // Mở màn hình thêm ghi chú
          );
          _refreshNotes(); // Tải lại ghi chú sau khi thêm mới
        },
      ),
    );
  }

  // Hàm xây dựng ListView cho danh sách ghi chú
  Widget _buildListView(List<Note> notes) {
    return ListView.separated(
      itemCount: notes.length,
      separatorBuilder: (context, index) => SizedBox(height: 8), // Thêm khoảng cách giữa các item
      itemBuilder: (context, index) {
        final note = notes[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 8), // Khoảng cách bên trái và phải của Card
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Bo tròn các góc của Card
          ),
          color: _getPriorityColor(note.priority), // Màu sắc của Card dựa trên độ ưu tiên
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
                MaterialPageRoute(builder: (context) => NoteDetailScreen(note: note)), // Mở màn hình chi tiết ghi chú
              );
              if (updated == true) {
                _refreshNotes(); // Tải lại ghi chú sau khi chỉnh sửa
              }
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Nút sửa
                IconButton(
                  icon: Icon(Icons.edit, color: Colors.blue),
                  onPressed: () async {
                    final updated = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditNoteScreen(note: note)), // Mở màn hình sửa ghi chú
                    );
                    if (updated == true) {
                      _refreshNotes();
                    }
                  },
                ),
                // Nút xoá
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    await NoteAPIService.instance.deleteNote(note.id!); // Xoá ghi chú khỏi database
                    _refreshNotes(); // Tải lại danh sách ghi chú
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Hàm xây dựng GridView cho danh sách ghi chú
  Widget _buildGridView(List<Note> notes) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Hiển thị 2 cột trong GridView
        childAspectRatio: 1.5, // Tỉ lệ của mỗi ô trong grid
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
              borderRadius: BorderRadius.circular(12), // Bo tròn các góc của Card
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

  // Hàm trả về màu sắc của ghi chú theo mức độ ưu tiên
  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red.shade100; // Màu đỏ cho ưu tiên cao
      case 2:
        return Colors.yellow.shade100; // Màu vàng cho ưu tiên trung bình
      case 3:
        return Colors.green.shade100; // Màu xanh cho ưu tiên thấp
      default:
        return Colors.grey.shade200; // Màu xám cho ghi chú không có ưu tiên
    }
  }
}
