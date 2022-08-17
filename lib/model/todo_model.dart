import 'package:flutter/material.dart';
/* import 'package:uuid/uuid.dart';

var _uuid = Uuid(); */

class TodoField {
  static const createdTime = "createdTime";
}

@immutable
class Todo {
  final DateTime createdTime;
  final String id;
  final String title;
  final String description;
  final bool isDone;

  //Constructor
  const Todo({
    required this.createdTime,
    required this.id,
    required this.title,
    this.description = "",
    this.isDone = false,
  });

  Todo copyWith(
      {DateTime? createdTime,
      String? id,
      String? title,
      String? description,
      bool? isDone}) {
    return Todo(
        createdTime: createdTime ?? this.createdTime,
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        isDone: isDone ?? this.isDone);
  }
}
