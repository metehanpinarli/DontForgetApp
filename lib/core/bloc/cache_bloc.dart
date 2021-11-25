import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dont_forget/core/model/cache_model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'cache_event.dart';

part 'cache_state.dart';

class CacheBloc extends Bloc<CacheEvent, CacheState> {
  CacheBloc() : super(CacheInitial()) {
    on<CacheSet>(_onCacheSet);

    on<CacheGet>(_onCacheGet);
  }

  Future<void> _onCacheSet(event, emit) async {
    try {
      emit(CacheLoading());
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setBool("switchMode", event.cacheModel.switchMode);
      pref.setString("time", event.cacheModel.time.toString());
      emit(CacheCompleted(CacheModel(event.cacheModel.time, event.cacheModel.switchMode)));
    } catch (e) {
      emit(CacheError("Hata Oluştu!"));
    }
  }

  Future<void> _onCacheGet(event, emit) async {
    try {
      emit(CacheLoading());
      SharedPreferences pref = await SharedPreferences.getInstance();
      bool? switchMode = pref.getBool("switchMode");
      if (switchMode != null) {
        DateTime? time = DateTime.parse(pref.getString("time")!);
        emit(CacheCompleted(CacheModel(time, switchMode)));
      }else{
        emit(CacheInitial());
      }
    } catch (e) {
      emit(CacheError("Hata oluştu!"));
    }
  }
}
