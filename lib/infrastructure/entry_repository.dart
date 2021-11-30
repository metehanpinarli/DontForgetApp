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
      bool? switchMode =_cacheManager.cacheGetSwitchMode();
      if (switchMode != null) {
        DateTime? time = DateTime.parse(_cacheManager.cacheGetTime()!);
        return Right(EntryModel(time, switchMode));
      } else {
        return const Left(NullValueFailure("Hata"));
      }
    } catch (e) {
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
