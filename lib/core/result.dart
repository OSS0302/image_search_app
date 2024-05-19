sealed class Result<T>  {
  factory Result.success(T data) = Success;
  factory Result.error(Exception e) = error;
}

class Success<T> implements Result<T> {
  final T data;

  Success(this.data);
}
class Error<T> implements Result<T> {
  Exception e;

  Error(this.e);
}