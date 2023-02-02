import 'dart:async';

import 'package:kanban_board/core/data/db/mappers/task_mapper.dart';
import 'package:kanban_board/features/board/data/datasource/tasks_local_data_source.dart';
import 'package:kanban_board/features/board/domain/entity/task.dart';
import 'package:kanban_board/features/board/domain/repository/tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final TasksLocalDataSource dataSource;

  TasksRepositoryImpl(this.dataSource);

  @override
  Stream<List<Task>> watchTasksFor(int columnId) {
    return dataSource.watchTasksFor(columnId).map((list) => list.map((task) => task.toEntity()).toList());
  }

  @override
  FutureOr<int> addTask(Task task) {
    return dataSource.addTask(TaskMapper.fromEntity(task));
  }

  @override
  FutureOr<bool> updateTask(Task task) {
    return dataSource.updateTask(TaskMapper.fromEntity(task));
  }

  @override
  FutureOr<int> deleteTask(int id) {
    return dataSource.deleteTask(id);
  }

  @override
  FutureOr<List<Task>> getTasksFor(int columnId) async {
    final tasksData = await dataSource.getTasksFor(columnId);
    return tasksData.map((task) => task.toEntity()).toList();
  }
}
