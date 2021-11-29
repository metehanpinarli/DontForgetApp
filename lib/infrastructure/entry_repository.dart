import 'package:dartz/dartz.dart';
import 'package:dont_forget/models/entry_model.dart';
import 'package:dont_forget/models/failure.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EntryRepository {
  Future<Either<Failure, EntryModel>> readCache() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      bool? switchMode = pref.getBool("switchMode");
      if (switchMode != null) {
        DateTime? time = DateTime.parse(pref.getString("time")!);
        return Right(EntryModel(time, switchMode));
      }else{
        return Left(NullValueFailure("Cache Üzerinde Veri Yok"));
      }
    } catch (e) {
      return Left(CacheFailure("Hata Oluştu"));
    }
  }

  Future<Either<Failure, Unit>> saveCache(EntryModel entryModel) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setBool("switchMode", entryModel.switchMode);
      pref.setString("time", entryModel.time.toString());
      return const Right(unit);
    } catch (e) {
      return Left(CacheFailure("Hata Oluştu"));
    }
  }
}
