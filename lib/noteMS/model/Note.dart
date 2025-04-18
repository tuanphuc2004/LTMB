// Định nghĩa class Note đại diện cho một ghi chú
class Note {
  int? id; // ID tự tăng, có thể null khi chưa lưu vào database
  String title; // Tiêu đề ghi chú
  String content; // Nội dung ghi chú
  int priority; // Mức độ ưu tiên: 1 - Thấp, 2 - Trung bình, 3 - Cao
  DateTime createdAt; // Thời gian tạo ghi chú
  DateTime modifiedAt; // Thời gian chỉnh sửa gần nhất
  List<String>? tags; // Danh sách tag phân loại ghi chú
  String? color; // Màu sắc ghi chú (mã HEX)

  // Constructor khởi tạo đối tượng Note
  Note({
    this.id,
    required this.title,
    required this.content,
    required this.priority,
    required this.createdAt,
    required this.modifiedAt,
    required this.tags,
    required this.color,
  });

  // Phương thức chuyển Note thành Map để lưu vào database
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'priority': priority,
      'createdAt': createdAt.toIso8601String(), // Chuyển ngày thành chuỗi ISO
      'modifiedAt': modifiedAt.toIso8601String(),
      'tags': tags?.join(','), // Nối tag thành chuỗi cách nhau bằng dấu phẩy
      'color': color,
    };
  }

  // Factory constructor tạo Note từ Map (lấy ra từ database)
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'], // Nếu null vẫn hợp lệ
      title: map['title'],
      content: map['content'],
      // Xử lý kiểu dữ liệu priority linh hoạt (có thể là int hoặc String)
      priority: map['priority'] is int
          ? map['priority']
          : int.tryParse(map['priority'].toString()) ?? 3,
      // Parse ngày từ chuỗi ISO
      createdAt: DateTime.parse(map['createdAt']),
      modifiedAt: DateTime.parse(map['modifiedAt']),
      // Chuyển chuỗi tag thành List<String>
      tags: map['tags'] is String ? (map['tags'] as String).split(',') : [],
      // Nếu không có color thì mặc định là trắng
      color: map['color'] is String ? map['color'] : '#FFFFFF',
    );
  }

  // Hàm copyWith giúp tạo bản sao Note với một số thuộc tính được thay đổi
  Note copyWith({
    int? id,
    String? title,
    String? content,
    int? priority,
    DateTime? createdAt,
    DateTime? modifiedAt,
    List<String>? tags,
    String? color,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt,
      tags: tags ?? this.tags,
      color: color ?? this.color,
    );
  }

  // Ghi đè phương thức toString để tiện debug/log thông tin ghi chú
  @override
  String toString() {
    return 'Note(id: $id, title: $title, content: $content, priority: $priority,'
        ' createdAt: $createdAt, modifiedAt: $modifiedAt, tags: $tags, color: $color)';
  }
}
