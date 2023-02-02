import 'package:kanban_board/core/base/base_bloc.dart';
import 'package:kanban_board/core/base/usecase.dart';
import 'package:kanban_board/features/board/domain/entity/board_column.dart';
import 'package:kanban_board/features/board/domain/usecase/get_columns_usecase.dart';
import 'package:kanban_board/features/board/presentation/bloc/board_event.dart';
import 'package:kanban_board/features/board/presentation/bloc/board_state.dart';

class BoardBloc extends BaseBloc<BoardEvent, BoardState> {
  final GetColumnsUseCase getColumns;

  BoardBloc(this.getColumns) : super(const BoardState()) {
    on<OnInit>((event, emit) => _onInit().forEach((state) => emit(state)));
    add(OnInit());
  }

  Stream<BoardState> _onInit() {
    return handle<List<BoardColumn>>(
      run: () => getColumns(EmptyUseCaseParams()),
      onSuccess: (result) => state.copyWith(columns: result),
    );
  }
}
