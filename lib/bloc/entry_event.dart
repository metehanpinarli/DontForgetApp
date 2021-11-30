part of 'entry_bloc.dart';

@immutable
abstract class EntryEvent {}

class EntrySet extends EntryEvent {
  final EntryModel entryModel;
  EntrySet(this.entryModel);
}

class EntryGet extends EntryEvent {
  EntryGet();
}
