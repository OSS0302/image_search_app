sealed class Result <T> {
  factory Result.success(T data) = Suceess;
  factory Result.error(Exception e) = Error;
}

class Suceess<T> implements Result<T> {
  final T data;

  Suceess(this.data);
}
class Error<T> implements Result<T> {
  Exception e;

  Error(this.e);


}