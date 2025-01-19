abstract class IResponseResult<DataType extends Object> {
  void resolve(
      {required Function(String message) onFail,
      required Function(DataType data) onSuccess}) {
    if (this is Success) {
      onSuccess((this as Success<DataType>).data);
      return;
    }

    if (this is Fail) {
      onFail((this as Fail).message);
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

  Fail(this.message);
}
