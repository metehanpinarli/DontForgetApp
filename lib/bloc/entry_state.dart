part of 'entry_bloc.dart';

@immutable
abstract class EntryState {}

class EntryInitial extends EntryState {}

class EntryLoading extends EntryState {}

class EntryCompleted extends EntryState {
  final EntryModel entryModel;
  EntryCompleted(this.entryModel);
}

class EntryError extends EntryState {
  final String message;
  EntryError(this.message);
}
