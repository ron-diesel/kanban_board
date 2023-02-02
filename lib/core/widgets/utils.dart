/// This fun help to make code ease and shorter for "buildWhen" and "listenWhen" params of [BlocBuilder] and [BlocListener]
/// [BuildWhenWrapper] returnable parameter must be equatable
BuildWhenCompanion<T> whenParamChanged<T>(BuildWhenWrapper<T> wrapper) {
  return (T previous, T current) => wrapper(previous) != wrapper(current);
}

typedef BuildWhenCompanion<T> = bool Function(T previous, T current);
typedef BuildWhenWrapper<T> = Object? Function(T state);
