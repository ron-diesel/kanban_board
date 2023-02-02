import 'dart:async';

import 'package:drift/drift.dart';
import 'package:kanban_board/core/data/db/database.dart';
import 'package:kanban_board/core/data/db/tables/tasks_table.dart';

part 'tasks_local_data_source.g.dart';

abstract class TasksLocalDataSource {
  Stream<List<TasksTableData>> watchTasksFor(int columnId);

  FutureOr<List<TasksTableData>> getTasksFor(int columnId);

  Future<int> addTask(TasksTableCompanion task);

  FutureOr<bool> updateTask(TasksTableCompanion task);

  FutureOr<int> deleteTask(int id);
}

@DriftAccessor(tables: [TasksTable])
class TaskDao extends DatabaseAccessor<Database> with _$TaskDaoMixin implements TasksLocalDataSource {
  TaskDao(Database db) : super(db);

  SimpleSelectStatement<$TasksTableTable, TasksTableData> _taskForQuery(int columnId) {
    return select(tasksTable)
      ..where((task) {
        return task.boardColumnId.equals(columnId);
      })
      ..orderBy([(t) => OrderingTerm(expression: t.lastColumnUpdate)]);
  }

  @override
  Stream<List<TasksTableData>> watchTasksFor(int columnId) {
    return _taskForQuery(columnId).watch();
  }

  @override
  FutureOr<List<TasksTableData>> getTasksFor(int columnId) {
    return _taskForQuery(columnId).get();
  }

  @override
  Future<int> addTask(TasksTableCompanion task) {
    return into(tasksTable).insert(task);
  }

  @override
  FutureOr<bool> updateTask(TasksTableCompanion task) {
    return update(tasksTable).replace(task);
  }

  @override
  FutureOr<int> deleteTask(int id) {
    return (delete(tasksTable)..where((task) => task.id.equals(id))).go();
  }
}
