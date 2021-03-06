import 'package:dont_forget/bloc/entry_bloc.dart';
import 'package:dont_forget/infrastructure/entry_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cacheManager/cache_manager.dart';
GetIt locator = GetIt.instance;

Future<void> setupLocator() async{
  final sharedPreferences=await SharedPreferences.getInstance();
  locator.registerLazySingleton<EntryRepository>(() => EntryRepository(locator<CacheManager>()));
  locator.registerLazySingleton<CacheManager>(() =>CacheManager(locator<SharedPreferences>()));
  locator.registerFactory<EntryBloc>(() => EntryBloc(locator<EntryRepository>()));
  locator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
}

