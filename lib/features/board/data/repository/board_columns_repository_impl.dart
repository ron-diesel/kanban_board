import 'package:kanban_board/core/app_strings.dart';
import 'package:kanban_board/features/board/domain/entity/board_column.dart';
import 'package:kanban_board/features/board/domain/repository/board_columns_repository.dart';

class BoardColumnsRepositoryImpl implements BoardColumnRepository {
  @override
  List<BoardColumn> getColumns() {
    return [
      const BoardColumn(name: AppStrings.todoColumn, id: 0),
      const BoardColumn(name: AppStrings.inProgressColumn, id: 1),
      const BoardColumn(name: AppStrings.doneColumn, id: 2),
    ];
  }
}
