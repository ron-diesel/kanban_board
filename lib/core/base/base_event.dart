import 'package:equatable/equatable.dart';

/// Base event for BLoC with [Equatable] for comparison in tests
class BaseEvent extends Equatable {
  @override
  List<Object?> get props => [];
}
