import '/data/response/status.dart';

class ApiResponse<T> {
  late T initial;
  late Status status;
  late T data;
  late String message;

  ApiResponse(this.status, this.data, this.message);

  ApiResponse.initial(this.initial) : status = Status.INITIAL;

  ApiResponse.loading() : status = Status.LOADING;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.error(this.message) : status = Status.ERROR;
}
