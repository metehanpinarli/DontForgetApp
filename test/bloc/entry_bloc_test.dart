import 'package:dartz/dartz.dart';
import 'package:dont_forget/bloc/entry_bloc.dart';
import 'package:dont_forget/infrastructure/entry_repository.dart';
import 'package:dont_forget/models/entry_model.dart';
import 'package:dont_forget/models/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockEntryRepository extends Mock implements EntryRepository {}

void main() {
  late MockEntryRepository mockEntryRepository;
  late EntryBloc entryBloc;
  late EntryModel testEntryModel;

  setUp(() {
    mockEntryRepository = MockEntryRepository();
    entryBloc=EntryBloc(mockEntryRepository);
    testEntryModel=EntryModel(DateTime.now(), true);
  });

  group("EntryGet", () {
    test(
      'EntryGet |Successful',
          () async {
       when(mockEntryRepository.readCache()).thenAnswer((_) async => Right<Failure,EntryModel>(testEntryModel));
        // SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
        // final  result= await EntryRepository(sharedPreferences).readCache();
        entryBloc.add(EntryGet());
        await untilCalled(mockEntryRepository.readCache());
        verify(mockEntryRepository.readCache());
      },
    );
  });
}