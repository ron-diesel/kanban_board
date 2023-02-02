import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/core/base/usecase.dart';
import 'package:kanban_board/core/di/base_di_module.dart';
import 'package:kanban_board/features/board/domain/entity/board_column.dart';
import 'package:kanban_board/features/board/presentation/bloc/board_bloc.dart';
import 'package:kanban_board/features/board/presentation/bloc/board_state.dart';
import 'package:mockito/mockito.dart';

import '../../../core/di/test_di_module.dart';
import '../../../core/di/test_di_module.mocks.dart';

const _column = BoardColumn(name: "column", id: 0);
const _columns = [_column];

void main() {
  group('BoardBloc event handling', () {
    TestsDiModule().init();
    final MockGetColumnsUseCase getColumns = getIt();

    BoardBloc build() => BoardBloc(getColumns);

    setUpAll(() {
      when(getColumns(any)).thenAnswer((_) => ResultSuccess(_columns));
    });

    blocTest(
      'OnInit',
      build: build,
      skip: TestsDiModule.skipHandle,
      expect: () => [const BoardState(columns: _columns)],
      verify: (_) => verify(getColumns(any)).called(1),
    );
  });
}
