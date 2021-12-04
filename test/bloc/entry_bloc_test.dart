import 'package:dartz/dartz.dart';
import 'package:dont_forget/bloc/entry_bloc.dart';
import 'package:dont_forget/infrastructure/entry_repository.dart';
import 'package:dont_forget/models/entry_model.dart';
import 'package:dont_forget/models/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'entry_bloc_test.mocks.dart';

class MockEntryBloc extends MockBloc<EntryEvent, EntryState> implements EntryBloc {}

@GenerateMocks([EntryRepository])
void main() {
  late MockEntryRepository mockEntryRepository;
  late EntryBloc entryBloc;
  late EntryModel entryModel;

  setUp(() async {
    mockEntryRepository = MockEntryRepository();
    entryBloc = EntryBloc(mockEntryRepository);
    entryModel = EntryModel(DateTime.now(), true);
  });

  group('EntryGet', () {

    blocTest<EntryBloc, EntryState>(
      'Successful',
      build: () {
        when(mockEntryRepository.readCache()).thenAnswer((_) async => Right(entryModel));
        return entryBloc;
      },
      act: (bloc) {
        bloc.add(EntryGet());
      },
      expect: () => <EntryState>[
        EntryLoading(),
        EntryCompleted(entryModel),
      ],
    );


    blocTest<EntryBloc, EntryState>(
      'Null Value',
      build: () {
        when(mockEntryRepository.readCache()).thenAnswer((_) async =>const Left(NullValueFailure("Hata")));
        return entryBloc;
      },
      act: (bloc) {
        bloc.add(EntryGet());
      },
      expect: () => <EntryState>[
        EntryLoading(),
        EntryInitial(),
      ],
    );


    blocTest<EntryBloc, EntryState>(
      'CacheFailure',
      build: () {
        when(mockEntryRepository.readCache()).thenAnswer((_) async =>const Left(CacheFailure("Hata")));
        return entryBloc;
      },
      act: (bloc) {
        bloc.add(EntryGet());
      },
      expect: () => <EntryState>[
        EntryLoading(),
        EntryError("Hata"),
      ],
    );

  });



  group('EntrySet', () {

    blocTest<EntryBloc, EntryState>(
      'Successful',
      build: () {
        when(mockEntryRepository.saveCache(entryModel: entryModel)).thenAnswer((_) async =>const Right(unit));
        return entryBloc;
      },
      act: (bloc) {
        bloc.add(EntrySet(entryModel));
      },
      expect: () => <EntryState>[
        EntryLoading(),
        EntryCompleted(entryModel),
      ],
    );


    blocTest<EntryBloc, EntryState>(
      'CacheFailure',
      build: () {
        when(mockEntryRepository.saveCache(entryModel: entryModel)).thenAnswer((_) async =>const Left(CacheFailure("Hata")));
        return entryBloc;
      },
      act: (bloc) {
        bloc.add(EntrySet(entryModel));
      },
      expect: () => <EntryState>[
        EntryLoading(),
        EntryError("Hata"),
      ],
    );

  });

}
