class Failure {
  final String message;

  Failure({this.message = "An error occurred. Please try again later."});

  @override
  String toString() => message;
}
