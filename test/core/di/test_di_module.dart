import 'package:kanban_board/core/di/base_di_module.dart';
import 'package:kanban_board/features/board/domain/usecase/add_task_usecase.dart';
import 'package:kanban_board/features/board/domain/usecase/delete_task_usecase.dart';
import 'package:kanban_board/features/board/domain/usecase/get_columns_usecase.dart';
import 'package:kanban_board/features/board/domain/usecase/share_column_usecase.dart';
import 'package:kanban_board/features/board/domain/usecase/update_task_usecase.dart';
import 'package:kanban_board/features/board/domain/usecase/watch_tasks_for_usecase.dart';
import 'package:kanban_board/features/board/presentation/column/bloc/column_bloc.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_bloc.dart';
import 'package:mockito/annotations.dart';

@GenerateNiceMocks([
  MockSpec<UpdateTaskUseCase>(),
  MockSpec<DeleteTaskUseCase>(),
  MockSpec<WatchTasksForUseCase>(),
  MockSpec<AddTaskUseCase>(),
  MockSpec<ShareColumnUseCase>(),
  MockSpec<GetColumnsUseCase>(),
  MockSpec<TaskBloc>(),
  MockSpec<ColumnBloc>(),
])
import 'test_di_module.mocks.dart';

class TestsDiModule extends BaseDIModule {
  /// if manageLoading = true in [handle] of [BaseBloc] set[skipHandle] to 1 else 0
  static int skipHandle = 0;

  @override
  void init() {
    /// UseCases
    getIt.registerFactory(() => MockUpdateTaskUseCase());
    getIt.registerFactory(() => MockDeleteTaskUseCase());
    getIt.registerFactory(() => MockWatchTasksForUseCase());
    getIt.registerFactory(() => MockAddTaskUseCase());
    getIt.registerFactory(() => MockShareColumnUseCase());
    getIt.registerFactory(() => MockGetColumnsUseCase());

    /// Blocs
    getIt.registerFactory(() => MockTaskBloc());
    getIt.registerFactory(() => MockColumnBloc());
  }
}
