import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kanban_board/core/base/base_state.dart';
import 'package:kanban_board/features/board/domain/entity/board_column.dart';

part 'board_state.freezed.dart';

@freezed
class BoardState extends IBaseState<BoardState> with _$BoardState {
  const BoardState._();

  const factory BoardState({
    @Default([]) List<BoardColumn> columns,
    @Default(BaseState()) BaseState baseState,
  }) = _BoardState;
}
