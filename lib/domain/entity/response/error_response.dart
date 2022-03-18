class ErrorResponse {
  const ErrorResponse(this.statusCode, this.message);

  final int statusCode;
  final String? message;
}
