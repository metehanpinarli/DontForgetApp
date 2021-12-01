import 'package:dartz/dartz.dart';
import 'package:dont_forget/bloc/entry_bloc.dart';
import 'package:dont_forget/cacheManager/cache_manager.dart';
import 'package:dont_forget/infrastructure/entry_repository.dart';
import 'package:dont_forget/models/entry_model.dart';
import 'package:dont_forget/models/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockEntryRepository extends Mock implements EntryRepository {
}

void main() {
  late MockEntryRepository mockEntryRepository;
  late EntryBloc moclanmisEntryBloc;

  setUp(()async {
    mockEntryRepository = MockEntryRepository();
    moclanmisEntryBloc = EntryBloc(mockEntryRepository);
  });

  group("EntryGet", () {

    test(
      //type 'Null' is not a subtype of type 'Future<Either<Failure, EntryModel>>
      'Moc EntryGet |Successful',
          () async {
        moclanmisEntryBloc.add(EntryGet());
      //  entryBloc.add(EntryGet());
      },
    );

    test(
      'EntryGet |Successful',
          () async {
        final sharedPreferences=await SharedPreferences.getInstance();
        final cacheManager=CacheManager(sharedPreferences);
        final entryRepository=EntryRepository(cacheManager);
        final entryBloc=EntryBloc(entryRepository);
        entryBloc.add(EntryGet());
       // entryBloc.add(EntryGet());
      },
    );




  });
}
