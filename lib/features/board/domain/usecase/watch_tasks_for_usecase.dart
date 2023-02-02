import 'dart:async';

import 'package:kanban_board/core/base/usecase.dart';
import 'package:kanban_board/features/board/domain/entity/board_column.dart';
import 'package:kanban_board/features/board/domain/entity/task.dart';
import 'package:kanban_board/features/board/domain/repository/tasks_repository.dart';

class WatchTasksForUseCase extends UseCase<Stream<List<Task>>, BoardColumn> {
  final TasksRepository repository;

  WatchTasksForUseCase(this.repository);

  @override
  FutureOr<Stream<List<Task>>> makeRequest(BoardColumn params) {
    return repository.watchTasksFor(params.id);
  }
}

