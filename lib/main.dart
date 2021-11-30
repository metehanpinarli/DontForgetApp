import 'package:dont_forget/bloc/entry_bloc.dart';
import 'package:dont_forget/injectable.dart';
import 'package:dont_forget/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main()async {
  //setup'da sorunsuz şekilde sharedPreferences kullanmak için gerekli.
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => locator<EntryBloc>(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:const HomeView(),
      ),
    );
  }
}
