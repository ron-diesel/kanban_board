import 'dart:async';

import 'package:kanban_board/core/app_strings.dart';
import 'package:kanban_board/core/base/usecase.dart';
import 'package:kanban_board/features/board/domain/entity/task.dart';
import 'package:kanban_board/features/board/domain/repository/tasks_repository.dart';

class DeleteTaskUseCase extends UseCase<int, Task> {
  final TasksRepository repository;

  DeleteTaskUseCase(this.repository);

  @override
  FutureOr<int> makeRequest(Task params) {
    return repository.deleteTask(params.id ?? (throw UseCaseException(AppStrings.invalidTask)));
  }
}
