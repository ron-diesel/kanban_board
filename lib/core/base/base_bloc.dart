import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_board/core/base/base_event.dart';
import 'package:kanban_board/core/base/base_state.dart';
import 'package:kanban_board/core/base/usecase.dart';

typedef RequestFun<T> = FutureOr<Result<T>> Function();
typedef OnSuccess<S extends IBaseState<S>, T> = S Function(T result);
typedef OnFailure<S extends IBaseState<S>, T> = S Function(ResultFailure<T> result);

abstract class BaseBloc<E extends BaseEvent, S extends IBaseState<S>> extends Bloc<E, S> {
  BaseBloc(S state) : super(state);

  /// Base method for processing the results of UseCases and automating the management of the loader and error messages
  /// [manageLoading] = false - disables automation of loader
  Stream<S> handle<T>({
    required RequestFun<T> run,
    required OnSuccess<S, T> onSuccess,
    OnFailure<S, T>? onFailure,
    bool manageLoading = false,
  }) async* {
    if (manageLoading) yield state.setLoading(true).invalidateError();
    final result = await run();
    if (result is ResultSuccess<T>) {
      final newState = onSuccess(result.result);
      yield newState.setLoading(manageLoading ? false : newState.isLoading).invalidateError();
    } else if (result is ResultFailure<T>) {
      debugPrint("failure bloc case ${result.errorMessage}");
      yield (onFailure?.call(result) ??
          state.setLoading(manageLoading ? false : state.isLoading).failure(result.errorMessage));
    } else {
      throw Exception("Unhandled UseCase result");
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    debugPrint("bloc error");
    super.onError(error, stackTrace);
  }
}
