import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dont_forget/infrastructure/entry_repository.dart';
import 'package:dont_forget/models/entry_model.dart';
import 'package:dont_forget/models/failure.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'entry_event.dart';
part 'entry_state.dart';

class EntryBloc extends Bloc<EntryEvent, EntryState> {
  final EntryRepository _entryRepository;

  EntryBloc(this._entryRepository) : super(EntryInitial()) {
    on<EntrySet>(_onCacheSet);
    on<EntryGet>(_onCacheGet);
  }

  Future<void> _onCacheSet(event, emit) async {
    emit(EntryLoading());
    final failureOrUnit = await _entryRepository.saveCache(entryModel:event.entryModel);
    failureOrUnit.fold((failure)=>emit(EntryError(failure.message)), (unit) => emit(EntryCompleted(EntryModel(event.entryModel.time, event.entryModel.switchMode))));
  }

  Future<void> _onCacheGet(event, emit) async {
    emit(EntryLoading());
    final failureOrEntryModel = await _entryRepository.readCache();
    failureOrEntryModel.fold((failure) =>failure is NullValueFailure? emit(EntryInitial()):emit(EntryError(failure.message)), (entryModel) => emit(EntryCompleted(EntryModel(entryModel.time, entryModel.switchMode))));
  }
}
