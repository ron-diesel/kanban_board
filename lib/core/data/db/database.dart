import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:kanban_board/core/data/db/tables/tasks_table.dart';
import 'package:kanban_board/features/board/data/datasource/tasks_local_data_source.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    TasksTable,
  ],
  daos: [
    TaskDao,
  ],
)
class Database extends _$Database {
  Database({NativeDatabase? testDatabase}) : super(testDatabase ?? _openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
