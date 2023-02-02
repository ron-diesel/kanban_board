import 'dart:async';

import 'package:flutter/foundation.dart';

abstract class UseCase<T, P> {
  FutureOr<Result<T>> call(P params) async {
    try {
      final result = await makeRequest(params);
      return ResultSuccess<T>(result);
    } on UseCaseException catch (e) {
      return ResultFailure<T>(e.textMessage);
    } catch (e, stackTrace) {
      debugPrint("UseCase Exception: $e\n$stackTrace");
      return ResultFailure<T>(e.toString());
    }
  }

  @protected
  FutureOr<T> makeRequest(P params);
}

class EmptyUseCaseParams {}

abstract class Result<T> {}

class ResultSuccess<T> extends Result<T> {
  final T result;

  ResultSuccess(this.result);
}

class ResultFailure<T> extends Result<T> {
  final String errorMessage;

  ResultFailure(this.errorMessage);
}

class UseCaseException implements Exception {
  final String textMessage;

  UseCaseException(this.textMessage);
}
