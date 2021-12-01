import 'package:dartz/dartz.dart';
import 'package:dont_forget/cacheManager/cache_manager.dart';
import 'package:dont_forget/infrastructure/entry_repository.dart';
import 'package:dont_forget/models/entry_model.dart';
import 'package:dont_forget/models/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;
  late CacheManager cacheManager;
  late EntryRepository entryRepository;
  late String testStringDateTime;
  late DateTime testDateTime;
  late bool testSwitchMode;
  late EntryModel testEntryModel;

  setUp(() {
    //SharedPreferences'ı dışarıdan aldığım için SharedPreferencesın kendi mockunu kullanmama gerek kalmadı.
    //SharedPreferences.setMockInitialValues({"switchMode": true, "time": DateTime.april.toString()});
    mockSharedPreferences = MockSharedPreferences();
    cacheManager = CacheManager(mockSharedPreferences);
    entryRepository = EntryRepository(cacheManager);
    testStringDateTime = "2021-11-30 17:40:08.067784";
    testSwitchMode = true;
    testDateTime = DateTime.parse("2021-11-30 17:40:08.067784");
    testEntryModel = EntryModel(testDateTime, testSwitchMode);
  });

  group('readCache', () {
    test(
      'Should Return EntryModel |Successful',
      () async {
        when(mockSharedPreferences.getBool("switchMode")).thenReturn(testSwitchMode);
        when(mockSharedPreferences.getString("time")).thenReturn(testStringDateTime);

        final result = await entryRepository.readCache();

        verify(mockSharedPreferences.getString("time"));
        verify(mockSharedPreferences.getBool("switchMode"));

        expect(result, equals(Right<Failure, EntryModel>(EntryModel(testDateTime, testSwitchMode))));
      },
    );
    test(
      'Should Return CacheFailure | Not time value ',
      () async {
        when(mockSharedPreferences.getBool("switchMode")).thenReturn(testSwitchMode);

        final result = await entryRepository.readCache();

        verify(mockSharedPreferences.getBool("switchMode"));

        expect(result, equals(const Left<Failure, EntryModel>(CacheFailure("Hata"))));
      },
    );

    test(
      'Should Return NullValueFailure | switchMode null ',
      () async {
        when(mockSharedPreferences.getBool("switchMode")).thenReturn(null);
        when(mockSharedPreferences.getString("time")).thenReturn(testStringDateTime);

        final result = await entryRepository.readCache();

        verify(mockSharedPreferences.getBool("switchMode"));

        expect(result, equals(const Left<Failure, EntryModel>(NullValueFailure("Hata"))));
      },
    );
  });

  group('saveCache', () {
    test(
      'Should return unit |Successful',
      () async {

        //mockSharedPreferences ile çalışmadı SharedPreferences gitmedi çözüm(@GenerateMocks([SharedPreferences]))
        final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        final CacheManager cacheManager = CacheManager(sharedPreferences);
        final result = await EntryRepository(cacheManager).saveCache(entryModel: testEntryModel);

        expect(result, equals(const Right<Failure, Unit>(unit)));
      },
    );

    test(
      'Should return CacheFailure |sharedPreferences Null',
      () async {
        // act
        final result = await entryRepository.saveCache(entryModel: testEntryModel);

        expect(result, equals(const Left<Failure, Unit>(CacheFailure("Hata"))));
      },
    );
  });
}
