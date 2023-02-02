import 'dart:async';

import 'package:kanban_board/features/board/domain/entity/task.dart';

abstract class TasksRepository {
  Stream<List<Task>> watchTasksFor(int columnId);

  FutureOr<int> addTask(Task task);

  FutureOr<bool> updateTask(Task task);

  FutureOr<int> deleteTask(int id);

  FutureOr<List<Task>> getTasksFor(int id);
}
