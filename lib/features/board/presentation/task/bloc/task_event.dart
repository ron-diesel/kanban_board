import 'package:kanban_board/core/base/base_event.dart';
import 'package:kanban_board/features/board/domain/entity/task.dart';

abstract class TaskEvent extends BaseEvent {}

class OnEditStart extends TaskEvent {
  final Task task;

  OnEditStart(this.task);
}

class OnEditCancel extends TaskEvent {}

class OnDeleteStart extends TaskEvent {}

class OnDeleteCancel extends TaskEvent {}

class OnDelete extends TaskEvent {
  final Task task;

  OnDelete(this.task);
}

class OnTimerSwitch extends TaskEvent {
  final Task task;

  OnTimerSwitch(this.task);
}

class OnExpand extends TaskEvent {}

class OnCollapse extends TaskEvent {}

class OnSaveInput extends TaskEvent {
  final Task task;

  OnSaveInput(this.task);
}

class OnInputUpdate extends TaskEvent {
  final String desc;

  OnInputUpdate(this.desc);
}
