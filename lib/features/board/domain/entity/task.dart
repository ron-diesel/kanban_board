import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:kanban_board/core/app_strings.dart';

part 'task.freezed.dart';

@freezed
class Task with _$Task {
  const Task._();

  const factory Task({
    int? id,
    required int columnId,
    required DateTime lastColumnUpdate,
    @Default(Duration.zero) Duration spentTimeStored,
    @Default(AppStrings.newTask) String desc,

    /// if timerStartAt != null, that launched time track
    @Default(null) DateTime? timerStartAt,
  }) = _Task;

  bool get isTimerLaunched => timerStartAt != null;

  Duration get spentTime {
    final startAt = timerStartAt;
    if (startAt != null) {
      return spentTimeStored + DateTime.now().difference(startAt);
    } else {
      return spentTimeStored;
    }
  }
}
