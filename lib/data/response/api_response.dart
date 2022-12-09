import 'package:mvvm/data/response/status.dart';

class ApiResponse<T> {
  Status ? status;
  T?data;
  String?message;

  ApiResponse(this.status,this.data,this.message);

  ApiResponse.loading():status =Status.LOGING;
  ApiResponse.completed(this.data):status =Status.COMPLATED;
  ApiResponse.error(this.message):status =Status.ERROR;



  @override
  String toString(){
    return 'Status : $status \n  Message : $message \n data : $data'; 
  }
}