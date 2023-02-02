import 'dart:async';

import 'package:kanban_board/core/base/usecase.dart';
import 'package:kanban_board/features/board/domain/entity/task.dart';
import 'package:kanban_board/features/board/domain/repository/tasks_repository.dart';

class AddTaskUseCase extends UseCase<int, Task> {
  final TasksRepository repository;

  AddTaskUseCase(this.repository);

  @override
  FutureOr<int> makeRequest(Task params) {
    return repository.addTask(params);
  }
}
