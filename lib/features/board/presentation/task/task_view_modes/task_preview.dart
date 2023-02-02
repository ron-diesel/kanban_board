import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kanban_board/core/app_dimens.dart';
import 'package:kanban_board/core/widgets/add_bloc_event.dart';
import 'package:kanban_board/features/board/domain/entity/task.dart';
import 'package:kanban_board/features/board/presentation/bloc/board_bloc.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_bloc.dart';
import 'package:kanban_board/features/board/presentation/task/bloc/task_event.dart';
import 'package:kanban_board/features/board/presentation/task/task_layout.dart';
import 'package:kanban_board/features/board/presentation/task/task_time_widget.dart';
import 'package:provider/provider.dart';

class TaskPreview extends StatelessWidget with AddEvent<TaskBloc, TaskEvent> {
  final Task task;
  final GlobalKey taskKey;

  const TaskPreview(
    this.task, {
    required this.taskKey,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<Task>(
      data: task,
      onDragUpdate: (details) {
        final columnsCount = context.read<BoardBloc>().state.columns.length;

        /// calculates scrolling acceleration
        /// so that scrolling is comfortable on all screen sizes with different columns count
        final boost = AppDimens.columnWidth * columnsCount / MediaQuery.of(context).size.width;
        _handleScroll(context.read<ScrollController>(), details, boost);
      },
      childWhenDragging: Opacity(
        opacity: 0.5,
        child: IgnorePointer(
          ignoring: true,
          child: _TaskPreviewContent(task),
        ),
      ),
      feedback: SizedBox(
        width: AppDimens.columnWidth - const EdgeInsets.all(8).horizontal,
        child: IgnorePointer(
          ignoring: true,
          child: _TaskPreviewContent(task),
        ),
      ),
      child: GestureDetector(
        onTap: () => add(context, OnExpand()),
        behavior: HitTestBehavior.opaque,
        child: _TaskPreviewContent(task, taskKey: taskKey),
      ),
    );
  }

  void _handleScroll(ScrollController scrollController, DragUpdateDetails details, double boost) {
    final calcPosition = scrollController.offset + details.delta.dx * boost * 2;
    final position = max(0, min(scrollController.position.maxScrollExtent, calcPosition));
    scrollController.jumpTo(position.toDouble());
  }
}

class _TaskPreviewContent extends StatelessWidget {
  final Task task;
  final GlobalKey? taskKey;

  const _TaskPreviewContent(
    this.task, {
    this.taskKey,
  });

  @override
  Widget build(BuildContext context) {
    return TaskLayout(
      key: taskKey,
      isExpand: false,
      taskId: task.id,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              task.desc,
              style: Theme.of(context).textTheme.bodyLarge,
              maxLines: 4,
              overflow: TextOverflow.fade,
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 40),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TaskTimeWidget(
                task,
                key: ValueKey(task.isTimerLaunched),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
