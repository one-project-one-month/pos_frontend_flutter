class ApiConstants {
  ApiConstants._();

  factory ApiConstants() {
    return I;
  }
  static final I = ApiConstants._();

  final baseUrl = "http://baseurl.com/api/";

  final get = "GET";
  final post = "POST";
  final put = "PUT";
  final delete = "DELETE";
}
