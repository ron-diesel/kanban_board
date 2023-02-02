import 'dart:async';

import 'package:kanban_board/core/base/base_bloc.dart';
import 'package:kanban_board/features/board/domain/entity/board_column.dart';
import 'package:kanban_board/features/board/domain/entity/task.dart';
import 'package:kanban_board/features/board/domain/usecase/add_task_usecase.dart';
import 'package:kanban_board/features/board/domain/usecase/share_column_usecase.dart';
import 'package:kanban_board/features/board/domain/usecase/update_task_usecase.dart';
import 'package:kanban_board/features/board/domain/usecase/watch_tasks_for_usecase.dart';
import 'package:kanban_board/features/board/presentation/column/bloc/column_event.dart';
import 'package:kanban_board/features/board/presentation/column/bloc/column_state.dart';

class ColumnBloc extends BaseBloc<ColumnEvent, ColumnState> {
  final WatchTasksForUseCase watchTasks;
  final AddTaskUseCase addTask;
  final UpdateTaskUseCase updateTask;
  final ShareColumnUseCase shareColumn;
  StreamSubscription? _taskSubscription;

  ColumnBloc({
    required BoardColumn column,
    required this.watchTasks,
    required this.addTask,
    required this.updateTask,
    required this.shareColumn,
  }) : super(ColumnState(column: column)) {
    on<OnTasksUpdate>((event, emit) => emit(state.copyWith(tasks: event.tasks)));
    on<OnInit>((event, emit) => _startWatchTasks().forEach((state) => emit(state)));
    on<OnAddTaskClick>((event, emit) => _addTask().forEach((state) => emit(state)));
    on<OnTaskDrop>((event, emit) => _changeTaskColumn(event.task).forEach((state) => emit(state)));
    on<OnShareClick>((event, emit) => _shareColumn().forEach((state) => emit(state)));
    add(OnInit());
  }

  Stream<ColumnState> _startWatchTasks() {
    return handle<Stream<List<Task>>>(
      run: () => watchTasks(state.column),
      onSuccess: (result) {
        _taskSubscription = result.listen((tasks) {
          add(OnTasksUpdate(tasks));
        });
        return state;
      },
    );
  }

  @override
  Future<void> close() async {
    await _taskSubscription?.cancel();
    return super.close();
  }

  Stream<ColumnState> _addTask() {
    return handle<void>(
      run: () => addTask(Task(columnId: state.column.id, lastColumnUpdate: DateTime.now())),
      onSuccess: (_) => state,
    );
  }

  Stream<ColumnState> _changeTaskColumn(Task task) {
    if (task.columnId == state.column.id) return Stream.value(state);
    return handle<void>(
      run: () => updateTask(task.copyWith(columnId: state.column.id, lastColumnUpdate: DateTime.now())),
      onSuccess: (_) => state,
    );
  }

  Stream<ColumnState> _shareColumn() {
    return handle<void>(
      run: () => shareColumn(state.column),
      onSuccess: (_) => state,
    );
  }
}
