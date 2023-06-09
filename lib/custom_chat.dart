library custom_chat;

import 'package:custom_chat/chat/cubit/chat_cubit.dart';
import 'package:custom_chat/chat/view/screens/chat_screen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomChat extends StatefulWidget {
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
  required this.baseUrl,
   this.voiceIcon,
   this.fileIcon,
   this.imageIcon,
   this.placeId,
   this.enableVoice=false,
   this.enableFile=false,
   this.enableImage=false,

  }) : super(key: key);
  String pusherChannel;
  String pusherEventRideStatusUpdated;
  String apiKey;
  String cluster;
  String baseUrl;
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
   Widget? voiceIcon;
   Widget? fileIcon;
   Widget? imageIcon;
   bool enableImage;
   bool enableFile;
   bool enableVoice;

  @override
  State<CustomChat> createState() => _CustomChatState();
}

class _CustomChatState extends State<CustomChat> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future(() async {    print("food2");
    //
    // await DioHelper.init();
    // print("food3");
    //
    // await PusherService.instance.init(
    //     myApiKey: widget.apiKey,
    //     myCluster: widget.cluster,
    //   );
    // });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

        home: ChangeNotifierProvider(
            create: (context) => ChatCubit(
                pusherChannel: widget.pusherChannel,
                pusherEventRideStatusUpdated: widget.pusherEventRideStatusUpdated,
                userId: widget.userId,
                accessToken: widget.accessToken,
                userDeviceToken: widget.userDeviceToken,
                getChatIdUrl: widget.getChatIdUrl,
                addChatMessageUrl: widget.addChatMessageUrl,
                getChatMessageUrl: widget.getChatMessageUrl),
            child: ChatScreen(

              apiKey: widget.apiKey,
                cluster: widget.cluster,
                placeId: widget.placeId,
                partnerId: widget.partnerId,
                partnerDeviceToken: widget.partnerDeviceToken,
                customAppBar: widget.customAppBar,
                appBarHeight: widget.appBarHeight,
                sendIcon: widget.sendIcon,
                baseUrl:widget.baseUrl,
                enableFile:widget.enableFile ,
              enableImage: widget.enableImage,
              enableVoice: widget.enableVoice,
              fileIcon: widget.fileIcon,
              imageIcon: widget.imageIcon,
              voiceIcon: widget.voiceIcon,

            ))

    );
  }
}
