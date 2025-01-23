import 'package:flutter/material.dart';

abstract class IResponseResult<DataType extends Object> {
  void resolve(
      {required Function(String message) onFail,
      required Function(DataType data) onSuccess}) {
    
    

    if (this is Success) {
      debugPrint('----------------- Response Result: Success ------------------');
      debugPrint('data: ${(this as Success<DataType>).data}');
      onSuccess((this as Success<DataType>).data);
      debugPrint('-------------------------------------------------------------');
      return;
    }

    if (this is Fail) {
      debugPrint('----------------- Response Result: Fail ---------------------');
      debugPrint('message: ${(this as Fail).message}');
      debugPrint('details: ${(this as Fail).details}');
      onFail((this as Fail).message);
      debugPrint('-------------------------------------------------------------');
      return;
    }
  }
}

class Success<DataType extends Object> extends IResponseResult<DataType> {
  final DataType data;

  Success(this.data);
}

class Fail<DataType extends Object> extends IResponseResult<DataType> {
  final String message;
  final Object details;

  Fail(this.message, this.details);
}
