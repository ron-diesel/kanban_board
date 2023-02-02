import 'package:kanban_board/core/base/base_event.dart';
import 'package:kanban_board/features/board/domain/entity/task.dart';

abstract class ColumnEvent extends BaseEvent {}

class OnInit extends ColumnEvent {}

class OnAddTaskClick extends ColumnEvent {}

class OnShareClick extends ColumnEvent {}

class OnTasksUpdate extends ColumnEvent {
  final List<Task> tasks;

  OnTasksUpdate(this.tasks);
}

class OnTaskDrop extends ColumnEvent {
  final Task task;

  OnTaskDrop(this.task);
}
