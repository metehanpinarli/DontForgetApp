import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dont_forget/infrastructure/entry_repository.dart';
import 'package:dont_forget/models/entry_model.dart';
import 'package:dont_forget/models/failure.dart';
import 'package:meta/meta.dart';

part 'entry_event.dart';

part 'entry_state.dart';

class EntryBloc extends Bloc<CacheEvent, CacheState> {
  final EntryRepository _entryRepository;

  EntryBloc(this._entryRepository) : super(CacheInitial()) {
    on<CacheSet>(_onCacheSet);
    on<CacheGet>(_onCacheGet);
  }

  Future<void> _onCacheSet(event, emit) async {
    emit(CacheLoading());
    final failureOrUnit = await _entryRepository.saveCache(event.entryModel);
    failureOrUnit.fold((failure)=>emit(CacheError(failure.message)), (unit) => emit(CacheCompleted(EntryModel(event.entryModel.time, event.entryModel.switchMode))));
  }

  Future<void> _onCacheGet(event, emit) async {
    emit(CacheLoading());
    final failureOrEntryModel = await _entryRepository.readCache();
    failureOrEntryModel.fold((failure) =>failure is NullValueFailure?emit(CacheInitial()):CacheError(failure.message), (entryModel) => emit(CacheCompleted(EntryModel(entryModel.time, entryModel.switchMode))));
  }
}
