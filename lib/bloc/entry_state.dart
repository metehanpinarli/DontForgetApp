part of 'entry_bloc.dart';

@immutable
abstract class EntryState extends Equatable{}

class EntryInitial extends EntryState {
  EntryInitial();

  @override
  List<Object?> get props =>[EntryInitial];
}

class EntryLoading extends EntryState {
  EntryLoading();

  @override
  List<Object?> get props =>[EntryLoading];
}

class EntryCompleted extends EntryState {
  final EntryModel entryModel;
  EntryCompleted(this.entryModel);

  @override
  List<Object?> get props =>[entryModel];
}

class EntryError extends EntryState {
  final String message;
  EntryError(this.message);

  @override
  List<Object?> get props =>[message];
}
