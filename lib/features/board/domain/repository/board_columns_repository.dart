import 'package:kanban_board/features/board/domain/entity/board_column.dart';

abstract class BoardColumnRepository {
  List<BoardColumn> getColumns();
}
