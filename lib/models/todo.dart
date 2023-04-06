import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  final String id;
  final String title;
  final bool completed;
  final bool isFavorite;
  final DateTime createdAt;

  Todo({
    required this.id,
    this.isFavorite = false,
    required this.title,
    required this.createdAt,
    this.completed = false,
  });

  // Todo.fromJson(Map<String, dynamic> json)
  //     : id = json['id'],
  //       title = json['title'],
  //       createdAt = (json['createdAt'] as Timestamp).toDate(),
  //       completed = json['completed'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'isFavorite': isFavorite,
        'title': title,
        'completed': completed,
        'createdAt': DateTime.now(),
      };

  factory Todo.fromJson(DocumentSnapshot snapshot) {
    return Todo(
      isFavorite: snapshot['isFavorite'],
      id: snapshot.id,
      title: snapshot['title'],
      createdAt: (snapshot['createdAt'] as Timestamp).toDate(),
      completed: snapshot['completed'],
    );
  }
}
