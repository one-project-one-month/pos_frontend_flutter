class Success {
  final Object response;
  Success({required this.response});
}

class Failure {
  Object errorResponse;
  Failure({required this.errorResponse});
}
