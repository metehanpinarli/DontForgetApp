import 'package:dont_forget/bloc/entry_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'custom_cupertino_switch_widget.dart';
import 'custom_text_widget.dart';

class CardContents extends StatelessWidget {
  const CardContents({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntryBloc, CacheState>(
      builder: (context, state) {
        if (state is CacheLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CacheCompleted) {
          return buildCacheCompletedColumn(state);
        } else if (state is CacheError) {
          return Center(child: Text(state.message));
        }
        return buildColumn();
      },
    );
  }

  Column buildColumn() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [CustomText(text: "HI!"), CustomCupertinoSwitch(value: false)],
      );
  }

  Column buildCacheCompletedColumn(CacheCompleted state) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomText(text: DateFormat('hh:mm:ss').format(state.entryModel.time).toString()),
            CustomCupertinoSwitch(value: state.entryModel.switchMode),
          ],
        );
  }
}