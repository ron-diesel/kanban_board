import 'package:drift/drift.dart';

class TasksTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get desc => text()();

  IntColumn get spentTime => integer()(); // seconds

  IntColumn get boardColumnId => integer()();

  DateTimeColumn get lastColumnUpdate => dateTime()();

  /// if timerStartAt != null, that launched time track
  DateTimeColumn get timerStartAt => dateTime().nullable()();
}
