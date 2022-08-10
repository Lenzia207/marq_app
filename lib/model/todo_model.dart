class TodoField {
  static const createdTime = "createdTime";
}

class Todo {
  DateTime createdTime;
  String id;
  String title;
  String description;
  bool isDone;

  //Constructor
  Todo({
    required this.createdTime,
    required this.id,
    required this.title,
    this.description = "",
    this.isDone = false,
  });
}
