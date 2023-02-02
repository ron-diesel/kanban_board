import 'dart:async';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:kanban_board/core/app_extensions.dart';
import 'package:kanban_board/core/app_strings.dart';
import 'package:kanban_board/core/base/usecase.dart';
import 'package:kanban_board/features/board/domain/entity/board_column.dart';
import 'package:kanban_board/features/board/domain/entity/task.dart';
import 'package:kanban_board/features/board/domain/repository/tasks_repository.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

const _dateFormat = 'dd.MM.yyyy HH:mm';
const _fileNamDateFormat = 'dd-MM-yy_HH-mm';

class ShareColumnUseCase extends UseCase<void, BoardColumn> {
  TasksRepository repository;
  ListToCsvConverter listToCsvConverter;

  ShareColumnUseCase(this.repository, this.listToCsvConverter);

  @override
  FutureOr<void> makeRequest(BoardColumn params) async {
    final csv = await _toCsv(params);
    final file = await _writeFile(csv);
    await FlutterShare.shareFile(
      title: AppStrings.shareTitle,
      filePath: file.path,
    );
  }

  Future<File> _writeFile(String csv) async {
    final fileName = "${DateTime.now().format(_fileNamDateFormat)}_${AppStrings.shareFileName}";
    final dir = await getTemporaryDirectory();
    final file = File(path.join(dir.path, fileName));
    return file.writeAsString(csv);
  }

  Future<String> _toCsv(BoardColumn column) async {
    final tasks = await repository.getTasksFor(column.id);
    final preParedTask = tasks.map((task) => _dataRow(task)).toList();
    return listToCsvConverter.convert([
      _headerRow(column),
      ...preParedTask,
    ]);
  }

  List<String> _headerRow(BoardColumn column) => [
        AppStrings.taskId,
        AppStrings.taskDesc,
        AppStrings.spentTime,
        '${AppStrings.addedTo} "${column.name}"',
      ];

  List<String> _dataRow(Task task) => [
        task.id.toString(),
        task.desc,
        _formatDuration(task.spentTime),
        task.lastColumnUpdate.format(_dateFormat),
      ];

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
