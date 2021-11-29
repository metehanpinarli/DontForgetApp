part of 'entry_bloc.dart';

@immutable
abstract class CacheEvent {}

class CacheSet extends CacheEvent {
  final EntryModel entryModel;
  CacheSet(this.entryModel);
}

class CacheGet extends CacheEvent {
  CacheGet();
}
