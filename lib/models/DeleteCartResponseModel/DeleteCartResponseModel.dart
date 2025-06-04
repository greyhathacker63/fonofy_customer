
class DeleteCartResponseModel {
  final dynamic success;
  final dynamic message;

  DeleteCartResponseModel({this.success, this.message});

  factory DeleteCartResponseModel.fromJson(Map<String, dynamic> json) {
    return DeleteCartResponseModel(
      success: json['success'],
      message: json['message'],
    );
  }
}
