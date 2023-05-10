library custom_chat;

import 'package:custom_chat/chat/cubit/chat_cubit.dart';
import 'package:custom_chat/chat/view/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomChat extends StatelessWidget {
   CustomChat({
    Key? key,
  required this.pusherChannel,
  required this.pusherEventRideStatusUpdated,
  required this.apiKey,
  required this.cluster,
  required this.getChatIdUrl,
  required this.addChatMessageUrl,
  required this.getChatMessageUrl,
  required this.accessToken,
  required this.userDeviceToken,
  required this.partnerDeviceToken,
  required this.userId,
  required this.partnerId,
  required this.appBarHeight,
  required this.customAppBar,
  required this.sendIcon,
   this.placeId,

  }) : super(key: key);
  String pusherChannel;
  String pusherEventRideStatusUpdated;
  String apiKey;
  String cluster;
  String getChatIdUrl;
  String addChatMessageUrl;
  String getChatMessageUrl;
  String accessToken;
  String userDeviceToken;
  String partnerDeviceToken;
  int userId;
  int partnerId;
  int? placeId;
  double appBarHeight;
  Widget customAppBar;
  Widget sendIcon;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ChatCubit(
            pusherChannel: pusherChannel,
            pusherEventRideStatusUpdated: pusherEventRideStatusUpdated,
            userId: userId,
            accessToken: accessToken,
            userDeviceToken: userDeviceToken,
            getChatIdUrl: getChatIdUrl,
            addChatMessageUrl: addChatMessageUrl,
            getChatMessageUrl: getChatMessageUrl),
        child: ChatScreen(
          placeId: placeId,
            apiKey: apiKey,
            cluster: cluster,
            partnerId: partnerId,
            partnerDeviceToken: partnerDeviceToken,
            customAppBar: customAppBar,
            appBarHeight: appBarHeight,
            sendIcon: sendIcon));
  }
}
