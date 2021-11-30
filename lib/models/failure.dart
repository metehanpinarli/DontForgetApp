import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable{
  final String message;

  const Failure(this.message);
}

class CacheFailure extends Failure {
  const CacheFailure(String message) : super(message);

  @override
  List<Object?> get props =>[message];

}

class NullValueFailure extends Failure {

  const NullValueFailure(String message) : super(message);

  @override
  List<Object?> get props =>[message];
}