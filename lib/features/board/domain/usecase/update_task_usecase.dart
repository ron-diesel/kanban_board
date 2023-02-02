import 'dart:async';

import 'package:kanban_board/core/base/usecase.dart';
import 'package:kanban_board/features/board/domain/entity/task.dart';
import 'package:kanban_board/features/board/domain/repository/tasks_repository.dart';

class UpdateTaskUseCase extends UseCase<bool, Task> {
  final TasksRepository repository;

  UpdateTaskUseCase(this.repository);

  @override
  FutureOr<bool> makeRequest(Task params) {
    return repository.updateTask(params);
  }
}
