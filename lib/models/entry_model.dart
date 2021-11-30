import 'package:equatable/equatable.dart';

class EntryModel extends Equatable{
  DateTime time;
  bool switchMode;

  EntryModel(this.time, this.switchMode);

  @override
  List<Object?> get props =>[time,switchMode];
}