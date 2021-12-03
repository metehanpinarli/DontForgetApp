part of 'entry_bloc.dart';

@immutable
abstract class EntryState{}

class EntryInitial extends EntryState {
  EntryInitial();
}

class EntryLoading extends EntryState {
  EntryLoading();
}

class EntryCompleted extends EntryState {
  final EntryModel entryModel;
  EntryCompleted(this.entryModel);
}

class EntryError extends EntryState {
  final String message;
  EntryError(this.message);
}
