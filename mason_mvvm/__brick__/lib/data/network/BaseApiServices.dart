abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url);

  Future<dynamic> getPostApiResponse(String url, dynamic data,
      {Map<String, String>? headers});
  Future<dynamic> getpatchApiResponse(String url, dynamic data,
      {Map<String, String>? headers});
}
