import 'package:dont_forget/cacheManager/cache_manager.dart';
import 'package:dont_forget/models/entry_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cache_manager_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MockSharedPreferences mockSharedPreferences;
  late EntryModel entryModel;
  late bool testSwitchMode;
  late String testTime;
  late CacheManager cacheManager;

  setUp(() {
    testSwitchMode = true;
    testTime = "2021-11-30 17:40:08.067784";
    entryModel = EntryModel(DateTime.parse(testTime), testSwitchMode);
    mockSharedPreferences = MockSharedPreferences();
    cacheManager = CacheManager(mockSharedPreferences);
  });

  group('Get', () {
    test(
      'switchMode',
      () async {
        when(mockSharedPreferences.getBool("switchMode")).thenReturn(testSwitchMode);

        cacheManager.cacheGetSwitchMode();

        verify(mockSharedPreferences.getBool("switchMode"));
      },
    );

    test(
      'time',
      () async {
        when(mockSharedPreferences.getString("time")).thenReturn(testTime);

        cacheManager.cacheGetTime();

        verify(mockSharedPreferences.getString("time"));
      },
    );
  });

  group('Set', () {
    test(
      'switchMode and time',
      () async {
        //when de kullanmam gerektiği için yaptım
        Future<bool> test() async{
          return true;
        }
        when(mockSharedPreferences.setBool("switchMode",testSwitchMode)).thenAnswer((realInvocation) => test());
        when(mockSharedPreferences.setString("time",testTime)).thenAnswer((realInvocation) => test());
        cacheManager.cacheSet(entryModel);
        verify(mockSharedPreferences.setBool("switchMode", testSwitchMode));
        verify(mockSharedPreferences.setString("time", testTime));
      },
    );
  });
}
