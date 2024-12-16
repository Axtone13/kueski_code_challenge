abstract class Failure {
  final String message;
  Failure(this.message);

  @override
  String toString() => message;
}

class ServerFailure extends Failure {
  ServerFailure(super.message);
}

class ConnectionFailure extends Failure {
  ConnectionFailure(super.message);
}

class NotFoundFailure extends Failure {
  NotFoundFailure(super.message);
}

class UnauthorizedFailure extends Failure {
  UnauthorizedFailure(super.message);
}

class UnknownFailure extends Failure {
  UnknownFailure(super.message);
}