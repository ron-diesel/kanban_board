import 'package:drift/drift.dart';
import 'package:kanban_board/core/data/db/database.dart';
import 'package:kanban_board/features/board/domain/entity/task.dart';

extension TaskMapper on TasksTableData {
  Task toEntity() {
    return Task(
      id: id,
      lastColumnUpdate: lastColumnUpdate,
      spentTimeStored: Duration(seconds: spentTime),
      desc: desc,
      columnId: boardColumnId,
      timerStartAt: timerStartAt,
    );
  }

  static TasksTableCompanion fromEntity(Task task) {
    final id = task.id;
    return TasksTableCompanion.insert(
      id: id != null ? Value(id) : const Value.absent(),
      desc: task.desc,
      lastColumnUpdate: task.lastColumnUpdate,
      spentTime: task.spentTimeStored.inSeconds,
      boardColumnId: task.columnId,
      timerStartAt: Value(task.timerStartAt),
    );
  }
}
