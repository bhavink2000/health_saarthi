//@dart=2.9
import 'enums_status.dart';

class ApiResponseType<T>{
  Status status;
  String message;
  T data;

  ApiResponseType(this.status, this.message, this.data);

  ApiResponseType.loading() : status = Status.loading;

  ApiResponseType.error(this.message) : status = Status.error;

  ApiResponseType.complate(this.data) : status = Status.completed;

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data: $data";
  }
}