import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/core/di/base_di_module.dart';
import 'package:kanban_board/core/di/di_scope_widget.dart';
import 'package:kanban_board/features/board/data/datasource/tasks_local_data_source.dart';
import 'package:kanban_board/features/board/data/repository/board_columns_repository_impl.dart';
import 'package:kanban_board/features/board/data/repository/tasks_repository_impl.dart';
import 'package:kanban_board/features/board/domain/entity/board_column.dart';
import 'package:kanban_board/features/board/domain/entity/task.dart';
import 'package:kanban_board/features/board/domain/repository/board_columns_repository.dart';
import 'package:kanban_board/features/board/domain/repository/tasks_repository.dart';
import 'package:kanban_board/features/board/domain/usecase/add_task_usecase.dart';
import 'package:kanban_board/features/board/domain/usecase/delete_task_usecase.dart';
import 'package:kanban_board/features/board/domain/usecase/get_columns_usecase.dart';
import 'package:kanban_board/features/board/domain/usecase/share_column_usecase.dart';
import 'package:kanban_board/features/board/domain/usecase/update_task_usecase.dart';
import 'package:kanban_board/features/board/domain/usecase/watch_tasks_for_usecase.dart';
import 'package:kanban_board/features/board/presentation/bloc/board_bloc.dart';
import 'package:kanban_board/features/board/presentation/board_widget.dart';
import 'package:kanban_board/features/board/presentation/column/bloc/column_bloc.dart';
import 'package:kanban_board/features/board/presentation/column/column_widget.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_bloc.dart';
import 'package:kanban_board/features/board/presentation/task/task_widget.dart';

class BoardDIModule extends BaseDIModule {
  @override
  void init() {
    /// board
    getIt.registerFactory(() => BoardBloc(getIt()));
    getIt.registerFactory(() => GetColumnsUseCase(getIt()));
    getIt.registerFactory(() => const ListToCsvConverter());
    getIt.registerFactory(() => ShareColumnUseCase(getIt(), getIt()));
    getIt.registerFactory<BoardColumnRepository>(() => BoardColumnsRepositoryImpl());

    /// column
    getIt.registerFactoryParam<ColumnBloc, BoardColumn, void>(
      (column, _) => ColumnBloc(
        column: column,
        watchTasks: getIt(),
        addTask: getIt(),
        updateTask: getIt(),
        shareColumn: getIt(),
      ),
    );
    getIt.registerFactory(() => WatchTasksForUseCase(getIt()));
    getIt.registerFactory(() => AddTaskUseCase(getIt()));
    getIt.registerFactory(() => UpdateTaskUseCase(getIt()));

    getIt.registerFactory<TasksLocalDataSource>(() => TaskDao(getIt()));

    getIt.registerFactory<TasksRepository>(() => TasksRepositoryImpl(getIt()));

    /// task
    getIt.registerFactory(() => TaskBloc(
          updateTask: getIt(),
          deleteTask: getIt(),
        ));
    getIt.registerFactory(() => DeleteTaskUseCase(getIt()));
  }
}

class BoardModule {
  BoardModule._();

  static Widget get boardWidget {
    return DIScopeWidget(
      module: BoardDIModule(),
      child: BlocProvider<BoardBloc>(
        create: (_) => getIt(),
        child: const BoardWidget(),
      ),
    );
  }

  static Widget columnWidget(BoardColumn column) {
    return BlocProvider<ColumnBloc>(
      create: (_) => getIt.get(param1: column),
      child: const ColumnWidget(),
    );
  }

  static Widget taskWidget(Task task) {
    return BlocProvider<TaskBloc>(
      create: (_) => getIt(),
      child: TaskWidget(task),
    );
  }
}
