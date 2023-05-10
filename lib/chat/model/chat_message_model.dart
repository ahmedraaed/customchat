class ChatMessagesModel {
  bool? status;
  int? code;
  String? message;
  ChatMessagesPagination? data;

  ChatMessagesModel({this.status, this.code, this.message, this.data});

  ChatMessagesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null
        ? new ChatMessagesPagination.fromJson(json['data'])
        : null;
  }
}

class ChatMessagesPagination {
  int? currentPage;
  List<ChatMessagesData>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  ChatMessagesPagination(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  ChatMessagesPagination.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <ChatMessagesData>[];
      json['data'].forEach((v) {
        data!.add(new ChatMessagesData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class ChatMessagesData {
  dynamic id;
  dynamic messageType;
  dynamic message;
  dynamic file;
  dynamic audioDuration;
  dynamic fileName;
  dynamic isSeen;
  dynamic fromType;
  dynamic toType;
  dynamic hallsUserChatId;
  dynamic targetDeviceToken;
  dynamic createdAt;
  dynamic updatedAt;

  ChatMessagesData(
      {this.id,
      this.messageType,
      this.message,
      this.file,
      this.audioDuration,
      this.fileName,
      this.isSeen,
      this.fromType,
      this.toType,
      this.hallsUserChatId,
      this.targetDeviceToken,
      this.createdAt,
      this.updatedAt});

  ChatMessagesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    messageType = json['message_type'];
    message = json['message'];
    file = json['file'];
    audioDuration = json['audio_duration'];
    fileName = json['file_name'];
    isSeen = json['is_seen'];
    fromType = json['from_type'];
    toType = json['to_type'];
    hallsUserChatId = json['halls_user_chat_id'];
    targetDeviceToken = json['target_device_token'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
