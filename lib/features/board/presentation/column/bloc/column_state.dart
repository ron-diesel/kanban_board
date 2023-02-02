import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kanban_board/core/base/base_state.dart';
import 'package:kanban_board/features/board/domain/entity/board_column.dart';
import 'package:kanban_board/features/board/domain/entity/task.dart';

part 'column_state.freezed.dart';

@freezed
class ColumnState extends IBaseState<ColumnState> with _$ColumnState {
  const ColumnState._();

  const factory ColumnState({
    required BoardColumn column,
    @Default([]) List<Task> tasks,
    @Default(BaseState()) BaseState baseState,
  }) = _ColumnState;
}
