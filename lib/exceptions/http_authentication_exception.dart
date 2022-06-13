import 'package:flutter/foundation.dart';

class HttpAuthenticationException implements Exception {

  late String message;
  final String messageCode;
  final int code;

  HttpAuthenticationException(this.messageCode, this.code);

  @override
  String toString() {
    message = 'Error occurred';
    if (messageCode == describeEnum(AuthErrorCodes.EMAIL_EXISTS)) {
      message = 'User with this email already exists';
    } else if (messageCode == describeEnum(AuthErrorCodes.OPERATION_NOT_ALLOWED)) {
      message = 'Not allowed';
    } else if (messageCode == describeEnum(AuthErrorCodes.TOO_MANY_ATTEMPTS_TRY_LATER)) {
      message = 'Too many signup attempts. Please try again later';
    } else if (messageCode == describeEnum(AuthErrorCodes.EMAIL_NOT_FOUND)) {
      message = 'Email not found';
    } else if (messageCode == describeEnum(AuthErrorCodes.INVALID_PASSWORD)) {
      message = 'Invalid user password or email';
    } else if (messageCode == describeEnum(AuthErrorCodes.USER_DISABLED)) {
      message = 'User disabled';
    } else if (messageCode == describeEnum(AuthErrorCodes.WEEK_PASSWORD)) {
      message = 'Password should be longer';
    }

    return message;
  }
}

enum AuthErrorCodes {

  // signup
  EMAIL_EXISTS,
  OPERATION_NOT_ALLOWED,
  TOO_MANY_ATTEMPTS_TRY_LATER,
  WEEK_PASSWORD,

  // signin
  EMAIL_NOT_FOUND,
  INVALID_PASSWORD,
  USER_DISABLED

}