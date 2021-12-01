import 'package:dont_forget/cacheManager/cache_manager.dart';
import 'package:dont_forget/models/entry_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late EntryModel entryModel;
  late bool testswitchMode;
  late String testTime;
  late CacheManager cacheManager;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    testswitchMode = true;
    testTime = "2021-11-30 17:40:08.067784";
    entryModel = EntryModel(DateTime.parse(testTime), testswitchMode);
    cacheManager=CacheManager(mockSharedPreferences);
  });

  group('Get', () {
    test(
      'switchMode',
      () async {
        cacheManager.cacheGetSwitchMode();
        verify(mockSharedPreferences.getBool("switchMode"));
      },
    );

    test(
      'time',
      () async {
        cacheManager.cacheGetTime();
        verify(mockSharedPreferences.getString("time"));
      },
    );
  });

  group('Set', () {
    test(
      'switchMode and time',
      () async {
        //mock kullanınca null veriyor ve çalışmıyor
        cacheManager.cacheSet(entryModel);
        verify(mockSharedPreferences.setBool("switchMode", testswitchMode));
        verify(mockSharedPreferences.setString("time", testTime));
      },
    );
  });
}
