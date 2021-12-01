import 'package:dartz/dartz.dart';
import 'package:dont_forget/cacheManager/cache_manager.dart';
import 'package:dont_forget/models/entry_model.dart';
import 'package:dont_forget/models/failure.dart';


class EntryRepository {
  final CacheManager _cacheManager;

  EntryRepository(this._cacheManager);

  Future<Either<Failure, EntryModel>> readCache() async {
    try {
      //Test aşamasında daha rahat kullanabilmek için SharedPreferences dışarıdan aldım.
      //SharedPreferences pref = await SharedPreferences.getInstance();
      print("3");
      bool? switchMode =_cacheManager.cacheGetSwitchMode();
      print("4");
      if (switchMode != null) {
        print("5");
        DateTime? time = DateTime.parse(_cacheManager.cacheGetTime()!);
        return Right(EntryModel(time, switchMode));
      } else {
        print("6");
        print("null geldi");
        return const Left(NullValueFailure("Hata"));
      }
    } catch (e) {
      print("7");
      return const Left(CacheFailure("Hata"));
    }
  }

  Future<Either<Failure, Unit>> saveCache({required EntryModel entryModel}) async {
    try {
      _cacheManager.cacheSet(entryModel);
      return const Right(unit);
    } catch (e) {
      return const Left(CacheFailure("Hata"));
    }
  }
}
