part of 'entry_bloc.dart';

@immutable
abstract class CacheState {}

class CacheInitial extends CacheState {}

class CacheLoading extends CacheState {}

class CacheCompleted extends CacheState {
  final EntryModel entryModel;
  CacheCompleted(this.entryModel);
}

class CacheError extends CacheState {
  final String message;
  CacheError(this.message);
}
