import 'package:flutter/material.dart';
import 'package:kanban_board/core/app_colors.dart';
import 'package:kanban_board/core/widgets/card_container.dart';

class TaskDecoration extends StatelessWidget {
  final Widget child;
  final Color color;

  const TaskDecoration({
    super.key,
    required this.child,
    this.color = AppColors.surfaceVariant,
  });

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      color: color,
      child: AnimatedSize(
        alignment: Alignment.topCenter,
        duration: kThemeAnimationDuration,
        child: child,
      ),
    );
  }
}
