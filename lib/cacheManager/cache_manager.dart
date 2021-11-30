import 'package:dont_forget/models/entry_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {

  final SharedPreferences sharedPreferences;
  CacheManager(this.sharedPreferences);

  bool? cacheSetSwitchMode() {
    bool? switchMode = sharedPreferences.getBool("switchMode");
    return switchMode;
  }

  String? cacheSetTime() {
    String? time= sharedPreferences.getString("time");
    return time;
  }

  void cacheGet(EntryModel entryModel)  {
    sharedPreferences.setBool("switchMode", entryModel.switchMode);
    sharedPreferences.setString("time", entryModel.time.toString());
  }

}

