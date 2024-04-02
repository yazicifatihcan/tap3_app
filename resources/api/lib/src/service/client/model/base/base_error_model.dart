import 'package:api/src/index.dart';

/// Base error model for parsing api errors.
class BaseErrorModel extends IBaseModel<BaseErrorModel> {
  /// Constructor
  BaseErrorModel({
    this.errorCode,
    this.message,
  });

  /// Error code that represent that response code of the request
  String? errorCode;

  /// Message that represent that reason of the error
  String? message;

  @override
  BaseErrorModel fromJson(Map<String, dynamic> json) => BaseErrorModel(
        errorCode: json['error_code'] as String?,
        message: json['message'] as String?,
      );

  @override
  Map<String, dynamic> toJson() => {
        'error_code': errorCode,
        'message': message,
      };
}
