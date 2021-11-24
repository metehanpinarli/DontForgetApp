import 'package:dont_forget/core/bloc/cache_bloc.dart';
import 'package:dont_forget/core/model/cache_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
    context.read<CacheBloc>().add(CacheGet());
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

  Center buildBody() {
    return Center(
      child: Padding(
        padding: context.paddingMedium,
        child: Card(
          elevation: 20,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(context.normalRadius),
          ),
          child: buildAspectRatio(),
        ),
      ),
    );
  }

  AspectRatio buildAspectRatio() {
    return AspectRatio(
      aspectRatio: 3 / 2,
      child: buildBlocBuilder(),
    );
  }

  BlocBuilder<CacheBloc, CacheState> buildBlocBuilder() {
    return BlocBuilder<CacheBloc, CacheState>(
      builder: (context, state) {
        if (state is CacheCompleted) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildCustomText(context: context, text: DateFormat('hh:mm:ss').format(state.cacheModel.time).toString()),
              buildCupertinoSwitch(value: state.cacheModel.switchMode, context: context),
            ],
          );
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildCustomText(context: context, text: "HI!"),
            buildCupertinoSwitch(context: context, value: false),
          ],
        );
      },
    );
  }

  CupertinoSwitch buildCupertinoSwitch({required BuildContext context, required bool value}) {
    return CupertinoSwitch(
        value: value,
        onChanged: (val) {
          context.read<CacheBloc>().add(CacheSet(CacheModel(DateTime.now(), val)));
        });
  }

  Text buildCustomText({required BuildContext context, required String text}) {
    return Text(
      text,
      style: Theme.of(context).textTheme.headline2!.copyWith(color: Colors.black),
    );
  }
}
