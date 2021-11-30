import 'package:dartz/dartz.dart';
import 'package:dont_forget/models/entry_model.dart';
import 'package:dont_forget/models/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EntryRepository {
  final SharedPreferences _pref;

  const EntryRepository(this._pref);

  Future<Either<Failure, EntryModel>> readCache() async {
    try {
      //Test aşamasında daha rahat kullanabilmek için SharedPreferences dışarıdan aldım.
      //SharedPreferences pref = await SharedPreferences.getInstance();
      bool? switchMode = _pref.getBool("switchMode");
      if (switchMode != null) {
        DateTime? time = DateTime.parse(_pref.getString("time")!);
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
      _pref.setBool("switchMode", entryModel.switchMode);
      _pref.setString("time", entryModel.time.toString());
      return const Right(unit);
    }catch (e) {
      return const Left(CacheFailure("Hata"));
    }
  }
}
