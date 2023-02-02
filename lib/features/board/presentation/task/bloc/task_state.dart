import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kanban_board/core/base/base_state.dart';

part 'task_state.freezed.dart';

@freezed
class TaskState extends IBaseState<TaskState> with _$TaskState {
  const TaskState._();

  const factory TaskState({
    @Default(TaskViewMode.preview) TaskViewMode viewMode,
    @Default('') String descInput,
    @Default(BaseState()) BaseState baseState,
  }) = _TaskState;
}

enum TaskViewMode {
  preview,
  editing,
  expanded,
  deleting,
}
