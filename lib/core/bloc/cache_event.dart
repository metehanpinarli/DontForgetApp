part of 'cache_bloc.dart';

@immutable
abstract class CacheEvent {}

class CacheSet extends CacheEvent {
  final CacheModel cacheModel;
  CacheSet(this.cacheModel);
}

class CacheGet extends CacheEvent {
  CacheGet();
}
