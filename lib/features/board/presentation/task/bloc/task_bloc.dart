import 'package:kanban_board/core/base/base_bloc.dart';
import 'package:kanban_board/features/board/domain/entity/task.dart';
import 'package:kanban_board/features/board/domain/usecase/delete_task_usecase.dart';
import 'package:kanban_board/features/board/domain/usecase/update_task_usecase.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_event.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_state.dart';

class TaskBloc extends BaseBloc<TaskEvent, TaskState> {
  final UpdateTaskUseCase updateTask;
  final DeleteTaskUseCase deleteTask;

  TaskBloc({
    required this.updateTask,
    required this.deleteTask,
  }) : super(const TaskState()) {
    on<OnExpand>((event, emit) => emit(state.copyWith(viewMode: TaskViewMode.expanded)));
    on<OnCollapse>((event, emit) => emit(state.copyWith(viewMode: TaskViewMode.preview)));
    on<OnEditStart>((event, emit) => emit(_startEdit(event)));
    on<OnEditCancel>((event, emit) => emit(_cancelEdit()));
    on<OnDeleteStart>((event, emit) => emit(state.copyWith(viewMode: TaskViewMode.deleting)));
    on<OnDeleteCancel>((event, emit) => emit(state.copyWith(viewMode: TaskViewMode.expanded)));
    on<OnDelete>((event, emit) => _deleteTask(event.task).forEach((state) => emit(state)));
    on<OnSaveInput>((event, emit) => _saveTask(event.task).forEach((state) => emit(state)));
    on<OnInputUpdate>((event, emit) => emit(state.copyWith(descInput: event.desc)));
    on<OnTimerSwitch>((event, emit) => _switchTimer(event.task).forEach((state) => emit(state)));
  }

  Stream<TaskState> _saveTask(Task task) {
    return handle<bool>(
      run: () => updateTask(task.copyWith(desc: state.descInput.trim())),
      onSuccess: (_) => state.copyWith(viewMode: TaskViewMode.preview),
    );
  }

  Stream<TaskState> _deleteTask(Task task) {
    return handle<int>(
      run: () => deleteTask(task),
      onSuccess: (_) => state.copyWith(viewMode: TaskViewMode.preview),
    );
  }

  TaskState _startEdit(OnEditStart event) {
    return state.copyWith(viewMode: TaskViewMode.editing, descInput: event.task.desc);
  }

  TaskState _cancelEdit() {
    return state.copyWith(viewMode: TaskViewMode.expanded, descInput: '');
  }

  Stream<TaskState> _switchTimer(Task task) {
    return handle<bool>(
      run: () {
        return updateTask(_switchTimerHandle(task));
      },
      onSuccess: (_) => state,
    );
  }

  Task _switchTimerHandle(Task task) {
    if (task.isTimerLaunched) {
      return task.copyWith(timerStartAt: null, spentTimeStored: task.spentTime);
    } else {
      return task.copyWith(timerStartAt: DateTime.now());
    }
  }
}
