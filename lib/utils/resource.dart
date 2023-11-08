class Resource<T> {
  T? data;
  String? errorMessage;

  Resource._({this.data, this.errorMessage});
  factory Resource.success(T data) => Resource._(data: data);
  factory Resource.error(errorMessage) => Resource._(errorMessage: errorMessage);
  factory Resource.loading() => Resource._();
}