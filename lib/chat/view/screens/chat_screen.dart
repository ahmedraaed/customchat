import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../service/pusher_services/pusher_service.dart';
import '../../cubit/chat_cubit.dart';
import '../widgets/send_message.dart';
import '../widgets/showing_message.dart';




class ChatScreen extends StatefulWidget {
  ChatScreen({Key? key,


    this.placeId,
    required this.partnerId,
    required this.partnerDeviceToken,
    required this.customAppBar,
    required this.appBarHeight,
    required this.sendIcon,
  }) : super(key: key);

  int? placeId;
  int partnerId;
  String? partnerDeviceToken;
  Widget customAppBar;
  Widget sendIcon;
  double appBarHeight;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controller = TextEditingController();

  ScrollController scrollController = ScrollController();

  late ChatCubit chatCubit = context.read<ChatCubit>();
  bool showPlayer = false;
  String audioPath="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future(() async {
    //   await PusherService.instance.init(
    //     myApiKey:widget.apiKey ,
    //     myCluster:widget.cluster ,
    //   );
    //
    // });
    chatCubit.getChatId(
      hallId: widget.placeId,
      partnerId: widget.partnerId,
      partnerToken: widget.partnerDeviceToken!,
    );
    scrollController.addListener(() {
      _scroller(context: context, chatId: chatCubit.chatIdModel!.data!.id! );
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

    appBar:PreferredSize(

      preferredSize: Size.fromHeight(widget.appBarHeight),

      child:widget.customAppBar,
    ) ,
      body: Column(
        children: [
          Consumer<ChatCubit>(
            builder:(context, value, child) {

              if (chatCubit.listMessage.length<=0 && chatCubit.loadingMore == true) {
                return const Expanded(
                    child: Center(
                  child: CircularProgressIndicator(),
                ));
              } else {
                return chatCubit.listMessage.length > 0
                    ? MediaQuery.removePadding(
                        removeTop: true,
                        context: context,
                        child: Expanded(
                          child: ListView.separated(
                            controller: scrollController,
                            reverse: true,
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 20);
                            },
                            itemBuilder: (context, index) {
                              chatCubit.sendTime(index: index);
                              if(index < chatCubit.listMessage.length) {
                                return Align(
                                  alignment: chatCubit.listMessage[index].fromType == "partner"
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,
                                  child: SizedBox(
                                    width: 250,
                                    child: Column(
                                      crossAxisAlignment: chatCubit.listMessage[index]
                                                  .fromType ==
                                              "partner"
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      children: [
                                        ShowingMessage(
                                            chatCubit: chatCubit,
                                            messageType: chatCubit.listMessage[index]
                                                .messageType!,
                                            index: index),
                                        SizedBox(
                                          height: 1,
                                        ),
                                        Text(
                                          chatCubit.time,
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.grey),
                                          textAlign: TextAlign.end,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }else{
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child:  const Center(
                                      child: CircularProgressIndicator(color: Colors.black,)),
                                );
                              }
                            },
                            itemCount:chatCubit.loadingMore?
                                chatCubit.listMessage.length+1
                                :
                                chatCubit.listMessage.length
                            ,
                          ),
                        ),
                      )
                    : Expanded(child: Container());
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Consumer<ChatCubit>(
              builder:(context, value, child) {
                return Row(
                  textDirection: TextDirection.ltr,
                  children: [
                    InkWell(
                        onTap: () async {
                          setState(() {
                            sendMessage(controller: controller, chatCubit: chatCubit, widget: widget);
                          });
                        },
                        child:widget.sendIcon),
                    const SizedBox(width: 10),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Expanded(
                        child:
                        // chatCubit.imageFile == null
                        //     ? (chatCubit.file == null
                        //         ? (chatCubit.AudioFile ==null?
                            TextFormField(
                                    controller: controller,
                                    // onChanged: (val) {
                                    //
                                    //   controller.text = val;
                                    //   print(controller.text);
                                    // },
                                    textAlign: TextAlign.right,

                                    textDirection: TextDirection.ltr,
                                    decoration: InputDecoration(
                                      hintStyle: TextStyle(
                                          color: Colors.grey.withOpacity(0.7),
                                          fontSize: 13),
                                      hintText: 'اكتب رسالتك هنا',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(36),
                                          borderSide: BorderSide(
                                              color:
                                                  Colors.grey.withOpacity(0.5))),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(36),
                                          borderSide: BorderSide(
                                              color:
                                                  Colors.grey.withOpacity(0.5))),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(36),
                                          borderSide: BorderSide(
                                              color:
                                                  Colors.grey.withOpacity(0.5))),
                                      disabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(36),
                                          borderSide: BorderSide(
                                              color:
                                                  Colors.grey.withOpacity(0.5))),
                                      // prefixIcon: Padding(
                                      //   padding: const EdgeInsets.only(left: 20),
                                      //   child: Row(
                                      //     mainAxisSize: MainAxisSize.min,
                                      //     children: [
                                      //       InkWell(
                                      //           onTap: () {
                                      //             setState(() {
                                      //               chatCubit.selectImage();
                                      //             });
                                      //           },
                                      //           child: const Icon(
                                      //               Icons.camera_alt_outlined,
                                      //               color:
                                      //                   AppColor.redColor)),
                                      //       const SizedBox(width: 7),
                                      //       InkWell(
                                      //         onTap: (){
                                      //           chatCubit.selectFile();
                                      //         },
                                      //         child: const Icon(
                                      //           Icons.file_copy_sharp,
                                      //           color: AppColor.redColor,
                                      //         ),
                                      //       ),
                                      //       const SizedBox(width: 7),
                                      //       InkWell(
                                      //           onTap: () {
                                      //             // Navigator.push(
                                      //             //     context,
                                      //             //     MaterialPageRoute(
                                      //             //       builder: (context) =>
                                      //             //           Audoi(),
                                      //             //     ));
                                      //             showModalBottomSheet(
                                      //               context: context,
                                      //                 isScrollControlled: true,
                                      //
                                      //               builder: (context) {
                                      //
                                      //               return  SizedBox(
                                      //                 height: 150.h,
                                      //                 child: AudioRecorder(
                                      //                   onStop: (path) {
                                      //                     if (kDebugMode) print('Recorded file path: $path');
                                      //                     setState(() {
                                      //                       audioPath = path;
                                      //                       showPlayer = true;
                                      //                       chatCubit.setAudio(path);
                                      //                       chatCubit.selectAudio();
                                      //                       print(path);
                                      //                       Navigator.pop(context);
                                      //                     });
                                      //                   },
                                      //                 ),
                                      //               );
                                      //             },);
                                      //           },
                                      //           child: const Icon(
                                      //               Icons.settings_voice_rounded,
                                      //               color:
                                      //               AppColor.redColor)),
                                      //       const SizedBox(width: 7),
                                      //     ],
                                      //   ),
                                      // ),
                                    ),
                                  )
                        //     :
                        // Container(
                        //   height: 70.h,
                        //   padding: EdgeInsetsDirectional.all(10.sp),
                        //   decoration: BoxDecoration(
                        //     border: Border.all(
                        //         color: Colors.grey, width: 1.w),
                        //     borderRadius: BorderRadius.circular(10.r),
                        //   ),
                        //   child: Stack(children: [
                        //     PositionedDirectional(
                        //         bottom: 0,
                        //         end: 0,
                        //         child: Image(
                        //           image: const AssetImage("assets/images/audio_icon.png"),
                        //           height: 25.h,
                        //           width: 25.w,
                        //         )),
                        //     PositionedDirectional(
                        //         end: 0,
                        //         top: 0,
                        //         child: InkWell(
                        //           onTap: () {
                        //             setState(() {
                        //               chatCubit.clearAudio();
                        //             });
                        //           },
                        //           child: CircleAvatar(
                        //               radius: 10.r,
                        //               backgroundColor: Colors.redAccent,
                        //               child: Center(
                        //                 child: Icon(
                        //                   Icons.clear,
                        //                   color: Colors.white,
                        //                   size: 20.sp,
                        //                 ),
                        //               )),
                        //         )),
                        //   ]),
                        // ) )
                        //         : Container(
                        //             height: 70.h,
                        //             padding: EdgeInsetsDirectional.all(10.sp),
                        //             decoration: BoxDecoration(
                        //               border: Border.all(
                        //                   color: Colors.grey, width: 1.w),
                        //               borderRadius: BorderRadius.circular(10.r),
                        //             ),
                        //             child: Stack(children: [
                        //               PositionedDirectional(
                        //                   bottom: 0,
                        //                   end: 0,
                        //                   child: Icon(
                        //                     Icons.file_copy,
                        //                     size: 25.sp,
                        //                   )),
                        //               PositionedDirectional(
                        //                   end: 0,
                        //                   top: 0,
                        //                   child: InkWell(
                        //                     onTap: () {
                        //                       setState(() {
                        //                         chatCubit.clearFile();
                        //                       });
                        //                     },
                        //                     child: CircleAvatar(
                        //                         radius: 10.r,
                        //                         backgroundColor: Colors.redAccent,
                        //                         child: Center(
                        //                           child: Icon(
                        //                             Icons.clear,
                        //                             color: Colors.white,
                        //                             size: 20.sp,
                        //                           ),
                        //                         )),
                        //                   )),
                        //             ]),
                        //           ))
                        //     : Container(
                        //         height: 120.h,
                        //         padding: EdgeInsetsDirectional.all(10.sp),
                        //         decoration: BoxDecoration(
                        //           border:
                        //               Border.all(color: Colors.grey, width: 1.w),
                        //           borderRadius: BorderRadius.circular(10.r),
                        //         ),
                        //         child: Stack(children: [
                        //           PositionedDirectional(
                        //               bottom: 0,
                        //               end: 0,
                        //               child: Image.file(
                        //                 File(chatCubit.imageFile!.path),
                        //                 height: 90.h,
                        //                 width: 150.w,
                        //                 fit: BoxFit.cover,
                        //               )),
                        //           PositionedDirectional(
                        //               end: 0,
                        //               top: 0,
                        //               child: InkWell(
                        //                 onTap: () {
                        //                   setState(() {
                        //                     chatCubit.clearImage();
                        //                   });
                        //                 },
                        //                 child: CircleAvatar(
                        //                     radius: 10.r,
                        //                     backgroundColor: Colors.redAccent,
                        //                     child: Center(
                        //                       child: Icon(
                        //                         Icons.clear,
                        //                         color: Colors.white,
                        //                         size: 20.sp,
                        //                       ),
                        //                     )),
                        //               )),
                        //         ]),
                        //       ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }


  _scroller({required BuildContext context, required int chatId}) async {
    if (chatCubit
        .chatMessagesModel!
        .data!
        .nextPageUrl ==
        null) {
      return;
    } else if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      print("object");
      await chatCubit.getChatMessage(chatId: chatId);
      // await Future.delayed(const Duration(seconds: 5));
    }
  }
}
