class ChatIdModel {
  bool? status;
  int? code;
  String? message;
  ChatIdData? data;

  ChatIdModel({this.status, this.code, this.message, this.data});

  ChatIdModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new ChatIdData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ChatIdData {
  int? id;
  int? hallId;
  int? partnerId;
  int? userId;
  String? partnerDeviceToken;
  String? userDeviceToken;
  String? createdAt;
  String? updatedAt;

  ChatIdData(
      {this.id,
      this.hallId,
      this.partnerId,
      this.userId,
      this.partnerDeviceToken,
      this.userDeviceToken,
      this.createdAt,
      this.updatedAt});

  ChatIdData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    hallId = json['hall_id'];
    partnerId = json['partner_id'];
    userId = json['user_id'];
    partnerDeviceToken = json['partner_device_token'];
    userDeviceToken = json['user_device_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['hall_id'] = this.hallId;
    data['partner_id'] = this.partnerId;
    data['user_id'] = this.userId;
    data['partner_device_token'] = this.partnerDeviceToken;
    data['user_device_token'] = this.userDeviceToken;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
