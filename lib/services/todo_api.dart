import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/todo.dart';

class TodoApi {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final todosCollection = FirebaseFirestore.instance.collection('todos');

  Future<List<Todo>> fetchTodos() async {
    final snapshot = await firestore.collection('todos').orderBy('createdAt').get();
    return snapshot.docs.map((doc) => Todo.fromJson(doc)).toList();
  }

  Future<bool> createTodo(String title) async {
    final id = firestore.collection('todos').doc().id;
    final snapshot = await firestore.collection('todos').get();
    // if title already exists no need to create
    if (snapshot.docs
        .where((doc) {
          final existTodo = Todo.fromJson(doc);
          return existTodo.title == title;
        })
        .toList()
        .isNotEmpty) return false;

    await firestore.collection('todos').doc(id).set(
          Todo(
            id: id,
            createdAt: DateTime.now(),
            title: title,
          ).toJson(),
        );
    return true;
  }

  Future<void> completedChanged({
    required String id,
    required bool isCompleted,
  }) async {
    await firestore.collection('todos').doc(id).update(
      {
        'completed': isCompleted,
      },
    );
  }

  Future<void> selectAllTodos(bool select) async {
    final snapshot = await firestore.collection('todos').get();
    for (final doc in snapshot.docs) {
      await doc.reference.update(
        {
          'completed': select,
        },
      );
    }
  }

  Future<void> editTitleTodo({required String id, required String title}) async {
    await firestore.collection('todos').doc(id).update(
      {
        'title': title,
      },
    );
  }

  Future<void> deleteTodo(String id) async {
    await firestore.collection('todos').doc(id).delete();
  }

  Future<void> deleteAllTodos() async {
    final snapshot = await firestore.collection('todos').get();
    for (final doc in snapshot.docs) {
      await doc.reference.delete();
    }
  }

  Future<List<Todo>> fetchFavoriteTodos() async {
    final snapshot = await firestore.collection('todos').where('isFavorite', isEqualTo: true).get();
    return snapshot.docs.map((doc) => Todo.fromJson(doc)).toList();
  }

  Future<void> favoriteChanged({
    required String id,
    required bool isFavorite,
  }) async {
    await firestore.collection('todos').doc(id).update(
      {
        'isFavorite': isFavorite,
      },
    );
  }

  Future<Todo> fetchTodoById(String id) async {
    final snapshot = await firestore.collection('todos').doc(id).get();
    return Todo.fromJson(snapshot);
  }
}
