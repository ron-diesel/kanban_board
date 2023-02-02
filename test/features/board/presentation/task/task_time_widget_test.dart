import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kanban_board/features/board/domain/entity/task.dart';
import 'package:kanban_board/features/board/presentation/task/task_time_widget.dart';

class FakeTask extends Fake implements Task {
  @override
  bool isTimerLaunched;
  @override
  Duration spentTime;

  FakeTask({
    required this.isTimerLaunched,
    this.spentTime = Duration.zero,
  });
}

Future<void> _increaseSpentTime(FakeTask task, WidgetTester tester) async {
  // Increase spentTime by 5 seconds in model
  task.spentTime = task.spentTime + const Duration(seconds: 5);
  // Wait for the timer to change the state of the widget
  await tester.pumpAndSettle(const Duration(seconds: 1));
}

void main() {
  Widget build(FakeTask task) => MaterialApp(
        home: TaskTimeWidget(
          task,
          key: ValueKey(task.isTimerLaunched),
        ),
      );

  group('TaskTimeWidget', () {
    testWidgets('displays time correctly when launched', (WidgetTester tester) async {
      final task = FakeTask(isTimerLaunched: true, spentTime: const Duration(minutes: 10, seconds: 15));
      final widget = build(task);
      await tester.pumpWidget(widget);
      expect(find.text('10:15'), findsOneWidget);
      await _increaseSpentTime(task, tester);
      expect(find.text('10:20'), findsOneWidget);
    });

    testWidgets('displays time correctly when not launched', (WidgetTester tester) async {
      final task = FakeTask(isTimerLaunched: false, spentTime: const Duration(hours: 2, minutes: 48, seconds: 55));
      final widget = build(task);
      await tester.pumpWidget(widget);
      expect(find.text('02:48:55'), findsOneWidget);
      await _increaseSpentTime(task, tester);
      expect(find.text('02:48:55'), findsOneWidget);
    });

    testWidgets('displays time correctly when launched and add hours', (WidgetTester tester) async {
      final task = FakeTask(isTimerLaunched: true, spentTime: const Duration(minutes: 59, seconds: 59));
      final widget = build(task);
      await tester.pumpWidget(widget);
      expect(find.text('59:59'), findsOneWidget);
      await _increaseSpentTime(task, tester);
      expect(find.text('01:00:04'), findsOneWidget);
    });
  });
}
