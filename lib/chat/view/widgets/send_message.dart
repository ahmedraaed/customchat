import 'package:dio/dio.dart';

import '../../model/chat_message_model.dart';


// the way to send message that can be one of this options (text-audio-photo-file)
Future  sendMessage({required var controller,required var chatCubit,required var widget}) async {
  print("text****************************************");
  if (controller.text.isNotEmpty) {
    print("text****************************************");
    ChatMessagesData chatMessage = ChatMessagesData(
        message: controller.text.trim(),
        messageType: "text",
        fromType: "user",
        toType: "partner",
        createdAt: DateTime.now().toString());
    chatCubit.listMessage.insert(0, chatMessage);
    chatCubit.addChatMessage(
        chatId: chatCubit.chatIdModel!.data!.id!,
        messageType: "text",
        message: controller.text.trim(),
        partnerToken: widget.itemDetailsModel.partner!.deviceToken!);
    controller.clear();
  }
  else if (chatCubit.imageFile !=null) {
    ChatMessagesData chatMessage = ChatMessagesData(
        file: chatCubit.imageFile!.path,
        fileName: chatCubit.imageName,
        message: null,
        messageType: "image",
        fromType: "user",
        toType: "partner",
        createdAt: DateTime.now().toString());
    chatCubit.listMessage.insert(0, chatMessage);
    chatCubit.addChatMessage(
        chatId: chatCubit.chatIdModel!.data!.id!,
        messageType: "image",
        file: await MultipartFile.fromFile(chatCubit.imageFile!.path),
        fileName: chatCubit.imageName,
        partnerToken: widget.itemDetailsModel.partner!.deviceToken!);
    chatCubit.clearImage();
  }
  else if (chatCubit.file !=null) {
    print("text****************************************");

    ChatMessagesData chatMessage = ChatMessagesData(
        file: chatCubit.file!.path,
        fileName: chatCubit.fileName,
        message: null,
        messageType: "file",
        fromType: "user",
        toType: "partner",
        createdAt: DateTime.now().toString());
    chatCubit.listMessage.insert(0, chatMessage);
    chatCubit.addChatMessage(
        chatId: chatCubit.chatIdModel!.data!.id!,
        messageType: "file",
        file: await MultipartFile.fromFile(chatCubit.file!.path),
        fileName: chatCubit.fileName,
        partnerToken: widget.itemDetailsModel.partner!.deviceToken!);
    chatCubit.clearFile();
  } else if (chatCubit.AudioFile !=null) {
    print("text****************************************");

    ChatMessagesData chatMessage = ChatMessagesData(
        file: chatCubit.AudioFile!.path,
        fileName: "audio",
        message: null,
        messageType: "audio",
        fromType: "user",
        toType: "partner",
        createdAt: DateTime.now().toString());
    chatCubit.listMessage.insert(0, chatMessage);
    chatCubit.addChatMessage(
        chatId: chatCubit.chatIdModel!.data!.id!,
        messageType: "audio",
        file: await MultipartFile.fromFile(chatCubit.AudioFile!.path),
        fileName: "audio",
        partnerToken: widget.itemDetailsModel.partner!.deviceToken!);
    chatCubit.clearAudio();
  }
  else{
    print("nothing");
  }
}
