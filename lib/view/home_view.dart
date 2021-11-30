import 'package:dont_forget/bloc/entry_bloc.dart';
import 'package:dont_forget/widget/custom_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<EntryBloc>().add(EntryGet());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.red,
        body: buildBody(),
      ),
    );
  }

  Container buildBody() {
    return Container(
      decoration: buildBoxDecoration(),
      child: Center(
          child: Center(
        child: Padding(padding: context.paddingMedium, child: const CustomCard()),
      )),
    );

  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(gradient: LinearGradient(colors: [Colors.orange.shade400, Colors.purple.shade400, Colors.cyan.shade400], begin: Alignment.topCenter, end: Alignment.bottomCenter));
}
