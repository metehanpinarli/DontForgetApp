abstract class Failure{
  String message;

  Failure(this.message);
}

class CacheFailure extends Failure {
  CacheFailure(String message) : super(message);
}

class NullValueFailure extends Failure {
  NullValueFailure(String message) : super(message);
}