import 'package:dont_forget/bloc/entry_bloc.dart';
import 'package:dont_forget/infrastructure/entry_repository.dart';
import 'package:get_it/get_it.dart';
GetIt locator = GetIt.instance;

void setupLocator() async{
  locator.registerLazySingleton(() => EntryRepository());

  locator.registerFactory<EntryBloc>(() => EntryBloc(locator<EntryRepository>()));
}
