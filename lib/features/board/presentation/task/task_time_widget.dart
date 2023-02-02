import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kanban_board/core/app_colors.dart';
import 'package:kanban_board/features/board/domain/entity/task.dart';

class TaskTimeWidget extends StatefulWidget {
  final Task task;

  const TaskTimeWidget(
    this.task, {
    required super.key,
  });

  @override
  State<StatefulWidget> createState() => _TaskTimeWidgetState();
}

class _TaskTimeWidgetState extends State<TaskTimeWidget> {
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    if (widget.task.isTimerLaunched) {
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) => setState(() {}),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final task = widget.task;
    final color = task.isTimerLaunched ? AppColors.primary : AppColors.onSurface;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.timer_outlined,
          color: color,
          size: 16,
        ),
        const SizedBox(width: 4),
        Text(
          _formatDuration(task.spentTime),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: color,
            fontFeatures: [const FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    final hours = duration.inHours;
    return "${hours > 0 ? "${twoDigits(hours)}:" : ''}$twoDigitMinutes:$twoDigitSeconds";
  }
}
