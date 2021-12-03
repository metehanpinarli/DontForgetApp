import 'package:dartz/dartz.dart';
import 'package:dont_forget/bloc/entry_bloc.dart';
import 'package:dont_forget/infrastructure/entry_repository.dart';
import 'package:dont_forget/models/entry_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'entry_bloc_test.mocks.dart';

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

  group("EntryGet", () {
    test(
      'readCache |Successful',
      () async {
        when(mockEntryRepository.readCache()).thenAnswer((realInvocation) async => Right(EntryModel(DateTime.now(), true)));
        entryBloc.add(EntryGet());
        await untilCalled(mockEntryRepository.readCache());
        verify(mockEntryRepository.readCache());
      },
    );

    test(
      'deneme',
      () async {

        //Gelmesi gereken emit i dinleyemedim


        // Expected: should do the following in order:
        // * emit an event that <Instance of 'EntryLoading'>
        // * emit an event that <Instance of 'EntryCompleted'>
        // Actual: <Instance of 'EntryInitial'>
        // Which: was not a Stream or a StreamQueue



        final state = [EntryLoading(),EntryCompleted(entryModel)];
        when(mockEntryRepository.readCache()).thenAnswer((_) async => Right(entryModel));
        expectLater(entryBloc, emitsInOrder(state));
        entryBloc.add(EntryGet());

      },
    );


  });
}
