import '/config/response/status.dart';
import '/domain/failures/network/network_failure.dart';

class ApiResponse<T> {
  late T initial;
  late Status status;
  late T data;
  late NetworkFailure error;

  ApiResponse(this.status, this.data, this.error);

  ApiResponse.initial(this.initial) : status = Status.INITIAL;

  ApiResponse.loading() : status = Status.LOADING;

  ApiResponse.completed(this.data) : status = Status.COMPLETED;

  ApiResponse.error(this.error) : status = Status.ERROR;
}
