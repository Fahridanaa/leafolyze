class ApiResponse<T> {
  final String status;
  final String message;
  final T? data;

  const ApiResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    print(json);
    return ApiResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson([dynamic Function(T?)? toJsonT]) {
    return {
      'status': status,
      'message': message,
      'data': toJsonT != null && data != null ? toJsonT(data) : data,
    };
  }

  bool get isSuccess => status == 'success';
  bool get isFail => status == 'fail';
  bool get isError => status == 'error';

  // Helper methods to create responses
  static ApiResponse<T> success<T>({
    required String message,
    T? data,
  }) {
    return ApiResponse(
      status: 'success',
      message: message,
      data: data,
    );
  }

  static ApiResponse<T> fail<T>({
    required String message,
    T? data,
  }) {
    return ApiResponse(
      status: 'fail',
      message: message,
      data: data,
    );
  }

  static ApiResponse<T> error<T>({
    required String message,
    T? data,
  }) {
    return ApiResponse(
      status: 'error',
      message: message,
      data: data,
    );
  }
}
