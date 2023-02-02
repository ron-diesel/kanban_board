import 'package:freezed_annotation/freezed_annotation.dart';

part 'board_column.freezed.dart';

@freezed
class BoardColumn with _$BoardColumn {
  const factory BoardColumn({
    required String name,
    required int id,
  }) = _BoardColumn;
}
