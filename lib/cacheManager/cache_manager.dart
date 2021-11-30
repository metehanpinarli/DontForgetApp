import 'package:dont_forget/models/entry_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {

  final SharedPreferences sharedPreferences;
  CacheManager(this.sharedPreferences);

  bool? cacheGetSwitchMode() {
    bool? switchMode = sharedPreferences.getBool("switchMode");
    return switchMode;
  }

  String? cacheGetTime() {
    String? time= sharedPreferences.getString("time");
    return time;
  }

  void cacheSet(EntryModel entryModel)  {
    sharedPreferences.setBool("switchMode", entryModel.switchMode);
    sharedPreferences.setString("time", entryModel.time.toString());
  }

}

