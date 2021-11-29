import 'package:dont_forget/bloc/entry_bloc.dart';
import 'package:dont_forget/models/entry_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomCupertinoSwitch extends StatelessWidget {
  final bool value;
  const CustomCupertinoSwitch({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
        value: value,
        onChanged: (val) {
          BlocProvider.of<EntryBloc>(context).add(CacheSet(EntryModel(DateTime.now(), val)));
        });
  }
}