import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/core/app_colors.dart';
import 'package:kanban_board/core/app_dimens.dart';
import 'package:kanban_board/core/app_strings.dart';
import 'package:kanban_board/core/widgets/add_bloc_event.dart';
import 'package:kanban_board/core/widgets/card_container.dart';
import 'package:kanban_board/core/widgets/custom_icon_button.dart';
import 'package:kanban_board/core/widgets/text/body_text_large.dart';
import 'package:kanban_board/core/widgets/text/title_small.dart';
import 'package:kanban_board/core/widgets/utils.dart';
import 'package:kanban_board/features/board/di/module.dart';
import 'package:kanban_board/features/board/domain/entity/task.dart';
import 'package:kanban_board/features/board/presentation/column/bloc/column_bloc.dart';
import 'package:kanban_board/features/board/presentation/column/bloc/column_event.dart';
import 'package:kanban_board/features/board/presentation/column/bloc/column_state.dart';

class ColumnWidget extends StatelessWidget with AddEvent<ColumnBloc, ColumnEvent> {
  const ColumnWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: DragTarget<Task>(
        onAccept: (task) => add(context, OnTaskDrop(task)),
        builder: (context, candidateItems, _) {
          return SizedBox(
            width: AppDimens.columnWidth,
            child: Align(
              alignment: Alignment.topCenter,
              child: CardContainer(
                color: candidateItems.isNotEmpty ? AppColors.primaryMaterial.shade300 : AppColors.background,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Material(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                              child: BlocBuilder<ColumnBloc, ColumnState>(
                                buildWhen: whenParamChanged((state) => state.column),
                                builder: (context, state) => TitleSmall(state.column.name),
                              ),
                            )),
                            CustomIconButton(
                              onPressed: () => add(context, OnShareClick()),
                              icon: const Icon(
                                Icons.share,
                                color: AppColors.onSurface,
                              ),
                            ),
                            CustomIconButton(
                              onPressed: () => add(context, OnAddTaskClick()),
                              icon: const Icon(
                                Icons.add,
                                color: AppColors.primary,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: _ColumnList(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ColumnList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ColumnListState();
}

class _ColumnListState extends State<_ColumnList> with AddEventStateful<_ColumnList, ColumnBloc, ColumnEvent> {
  final ScrollController _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ColumnBloc, ColumnState>(
      listenWhen: (prev, curr) {
        return prev.tasks.isNotEmpty && curr.tasks.length > prev.tasks.length;
      },
      listener: (context, state) => _scrollToEnd(),
      builder: (context, state) {
        return ConstrainedBox(
          constraints: const BoxConstraints(minHeight: AppDimens.minColumnHeight),
          child: state.tasks.isEmpty
              ? SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => add(OnAddTaskClick()),
                    child: const BodyTextLarge(
                      AppStrings.clickToAddTask,
                      color: AppColors.onBackground,
                    ),
                  ),
                )
              : ListView.builder(
                  controller: _controller,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemBuilder: (context, index) {
                    final task = state.tasks[index];
                    return BoardModule.taskWidget(task);
                  },
                  itemCount: state.tasks.length,
                ),
        );
      },
    );
  }

  _scrollToEnd() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      debugPrint(timeStamp.toString());
      await _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: kThemeAnimationDuration,
        curve: Curves.ease,
      );
      _controller.jumpTo(_controller.position.maxScrollExtent); //fix scroll to end, after drop
    });
  }
}
