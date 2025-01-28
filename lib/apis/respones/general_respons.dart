// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

GeneralRespons generalResponsFromJson(String str) =>
    GeneralRespons.fromJson(json.decode(str));

String generalResponsToJson(GeneralRespons data) => json.encode(data.toJson());

class GeneralRespons {
  final bool? success;
  final String? message;
  dynamic data;
  final String? accessToken;

  GeneralRespons({
    this.success,
    this.message,
    this.data,
    this.accessToken,
  });

  factory GeneralRespons.fromJson(Map<String, dynamic> map) => GeneralRespons(
        success: map['success'] != null ? map['success'] as bool : null,
        message: map['message'] as String,
        data: map['data'] as dynamic,
        accessToken: map['token'] != null ? map['token'] as String : null,
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'message': message,
        'data': data,
        'token': accessToken,
      };

  GeneralRespons copyWith({
    bool? success,
    String? message,
    dynamic data,
    String? accessToken,
  }) {
    return GeneralRespons(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
      accessToken: accessToken ?? this.accessToken,
    );
  }

  @override
  bool operator ==(covariant GeneralRespons other) {
    if (identical(this, other)) return true;

    return other.success == success &&
        other.message == message &&
        other.data == data &&
        other.accessToken == accessToken;
  }

  @override
  int get hashCode {
    return success.hashCode ^
        message.hashCode ^
        data.hashCode ^
        accessToken.hashCode;
  }

  @override
  String toString() {
    return 'GeneralRespons(success: $success, message: $message, data: $data, accessToken: $accessToken)';
  }
}
