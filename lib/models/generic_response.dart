class GenericResponse {
  bool success;
  int status;
  String message;
  dynamic body;
  dynamic error;

  ///A custom class for getting response from an http request
  GenericResponse({
    this.success = false,
    this.status = 400,
    this.message = ' ',
    this.body,
    this.error,
  });
}
