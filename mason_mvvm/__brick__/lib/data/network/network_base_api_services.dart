abstract class NetworkBaseApiServices {
  Future<T> getApi<T>({required String url});

  Future<T> postApi<T>(
      {required String url,
      required Map<String, dynamic> body,
      Map<String, String>? headers});
  Future<T> patchApi<T>(
      {required String url,
      required Map<String, dynamic> body,
      Map<String, String>? headers});
}
