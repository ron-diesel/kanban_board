import 'package:freezed_annotation/freezed_annotation.dart';

part 'base_state.freezed.dart';

@freezed
class BaseState with _$BaseState {
  const BaseState._();

  const factory BaseState({
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _BaseState;
}

abstract class IBaseState<S> {
  final BaseState baseState;

  bool get isError => errorMessage != null;

  bool get isLoading => baseState.isLoading;

  String? get errorMessage => baseState.errorMessage;

  S _update(BaseState baseState) => (this as dynamic).copyWith(baseState: baseState);

  const IBaseState({
    this.baseState = const BaseState(isLoading: false, errorMessage: null),
  });

  S setLoading(bool isLoading) {
    return _update(baseState.copyWith(isLoading: isLoading));
  }

  S failure(String? errorMessage) {
    return _update(baseState.copyWith(errorMessage: errorMessage));
  }

  S invalidateError() {
    return _update(baseState.copyWith(errorMessage: null));
  }
}
