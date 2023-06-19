class NetworkRepository {
  // Future<Either<NetworkFailure, dynamic>> get(String url) async {
  //   try {
  //     var uri = Uri.parse(url);
  //     var response = await http.get(uri);
  //     final failure = _handleStatusCode(response.statusCode);
  //     if (failure != null) {
  //       return left(failure);
  //     }
  //     return right(jsonDecode(response.body));
  //   } catch (ex) {
  //     return left(NetworkFailure(error: ex.toString()));
  //   }
  // }

  // NetworkFailure? _handleStatusCode(int code) {
  //   if (code == 401) {
  //     return NetworkFailure(error: 'Unauthorized');
  //   }
  //   return null;
  // }
}
