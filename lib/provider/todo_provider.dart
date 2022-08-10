import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';

final todosProvider = ChangeNotifierProvider((ref) {
  return TodosProvider();
});

class TodosProvider extends ChangeNotifier {}
