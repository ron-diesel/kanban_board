import 'dart:async';

import 'package:kanban_board/core/base/usecase.dart';
import 'package:kanban_board/features/board/domain/entity/board_column.dart';
import 'package:kanban_board/features/board/domain/repository/board_columns_repository.dart';

class GetColumnsUseCase extends UseCase<List<BoardColumn>, EmptyUseCaseParams> {
  final BoardColumnRepository repository;

  GetColumnsUseCase(this.repository);

  @override
  FutureOr<List<BoardColumn>> makeRequest(EmptyUseCaseParams params) {
    return repository.getColumns();
  }
}
