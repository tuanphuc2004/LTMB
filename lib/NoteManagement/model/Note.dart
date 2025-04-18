class Note {
  int? id;
  String title;
  String content;
  int priority; // 1: Thấp, 2: Trung bình, 3: Cao
  DateTime createdAt;
  DateTime modifiedAt;
  List<String>? tags;
  String? color;

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

  // Chuyển đối tượng Note thành Map (toMap)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'priority': priority,
      'createdAt': createdAt.toIso8601String(), // chuẩn ngày giờ quốc tế
      'modifiedAt': modifiedAt.toIso8601String(),
      'tags': tags?.join(','),
      'color': color,
    };
  }

  // Tạo đối tượng Note từ Map (fromMap)
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
      priority: map['priority'] is int ? map['priority'] : int.tryParse(map['priority'].toString()) ?? 3,
      createdAt: DateTime.parse(map['createdAt']),
      modifiedAt: DateTime.parse(map['modifiedAt']),
      tags: map['tags'] is String ? (map['tags'] as String).split(',') : [],
      color: map['color'] is String ? map['color'] : '#FFFFFF',
    );
  }


  // Phương thức copy để tạo bản sao với một số thuộc tính được cập nhật
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
  @override
  String toString() {
    // TODO: implement toString
    return 'Note(id: $id, title: $title, content: $content, priority: $priority,'
        ' createdAt: $createdAt, modifiedAt: $modifiedAt, tags: $tags, color: $color)';
  }
}
