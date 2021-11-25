part of 'cache_bloc.dart';

@immutable
abstract class CacheState {}

class CacheInitial extends CacheState {}

class CacheLoading extends CacheState {}

class CacheCompleted extends CacheState {
  final CacheModel cacheModel;
  CacheCompleted(this.cacheModel);
}

class CacheError extends CacheState {
  final String message;
  CacheError(this.message);
}
