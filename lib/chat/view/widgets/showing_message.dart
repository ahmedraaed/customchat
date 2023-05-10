import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:voice_message_package/voice_message_package.dart';
import '../../cubit/chat_cubit.dart';


//the way to display message that can be one of this options(file-text-audio-photo)
Widget ShowingMessage({
  required String messageType,
  required int index ,
  required var chatCubit,
  // required String openImageUri,
  // required String imageUrl,
  // required String openFileUri,
  // required String imageUrl,

}) {
  // if (messageType == "image") {
  //   return InkWell(
  //       onTap: ()async{
  //         final Uri _url = Uri.parse(openImageUri);
  //
  //         print("++++++++++++++++++++++++++++++++++");
  //         print(_url);
  //
  //         await launchUrl(_url,mode: LaunchMode.externalApplication);
  //       },
  //       child: Card(
  //         color: chatCubit.listMessage[index].fromType ==
  //             "partner"
  //             ? const Color(0xff8D93AB).withOpacity(0.5)
  //             : const Color(0xff8D93AB),
  //         shape: chatCubit.listMessage[index].fromType ==
  //             "partner"
  //             ? const RoundedRectangleBorder(
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(20),
  //               topRight: Radius.circular(20),
  //               bottomRight: Radius.circular(20),
  //             ))
  //             : const RoundedRectangleBorder(
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(20),
  //               topRight: Radius.circular(20),
  //               bottomLeft: Radius.circular(20),
  //             )),
  //         elevation: 0,
  //         child: Container(
  //           width: 200,
  //           height: 200,
  //           margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
  //           decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(20),
  //             image:chatCubit.listMessage[index].file!
  //                 .startsWith('/chat-messages/')
  //                 ? DecorationImage(
  //               fit: BoxFit.fill,
  //               image:  NetworkImage( imageUrl,),
  //             ): DecorationImage(
  //               fit: BoxFit.fill,
  //               image:  FileImage(File(chatCubit.listMessage[index].file!),),
  //             ),
  //
  //           ),
  //         ),
  //       ));
  // } else if (messageType == "file") {
  //   return InkWell(
  //     onTap: () async {
  //       final Uri _url = Uri.parse("${AppString.baseUrl}${chatCubit.listMessage[index].file}");
  //
  //      // await openFile(url: "${AppString.baseUrl}${chatCubit.listMessage[index].file}",
  //      //      name:chatCubit.listMessage[index].fileName );
  //      await launchUrl(_url,mode: LaunchMode.externalApplication);
  //
  //      print("${AppString.baseUrl}${chatCubit.listMessage[index].file}");
  //
  //     },
  //     child: Card(
  //       color: chatCubit.listMessage[index].fromType ==
  //           "partner"
  //           ? const Color(0xff8D93AB).withOpacity(0.5)
  //           : const Color(0xff8D93AB),
  //       shape: chatCubit.listMessage[index].fromType ==
  //           "partner"
  //           ? const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(50),
  //             topRight: Radius.circular(50),
  //             bottomRight: Radius.circular(50),
  //           ))
  //           : const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(50),
  //             topRight: Radius.circular(50),
  //             bottomLeft: Radius.circular(50),
  //           )),
  //       elevation: 0,
  //       child: Padding(
  //         padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
  //         child: Row(
  //           mainAxisAlignment: chatCubit.listMessage[index].fromType ==
  //               "partner"
  //               ?MainAxisAlignment.start:MainAxisAlignment.end,
  //           children: [
  //             Icon(
  //               Icons.file_copy,
  //               size: 35.sp,
  //               color: Colors.deepPurple,
  //             ),
  //             SizedBox(width: 10.w),
  //             Expanded(
  //               child: Text(
  //                 maxLines: 1,
  //                 textDirection:
  //                 chatCubit.listMessage[index].fromType ==
  //                     "partner"
  //                     ? TextDirection.ltr
  //                     : TextDirection.rtl,
  //                 '${chatCubit.listMessage[index].fileName!}',
  //                 style: TextStyle(
  //                   overflow: TextOverflow.clip,
  //                   color: chatCubit.listMessage[index].fromType ==
  //                       "partner"
  //                       ? Colors.black
  //                       : Colors.white,
  //                   fontSize: 13.sp,
  //                 ),
  //
  //               ),
  //             ),
  //             SizedBox(width: 10.w),
  //             Icon(
  //               Icons.file_download,
  //               size: 25.sp,
  //               color: Colors.white,
  //             ),
  //
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }else if (messageType == "audio") {
  //   return Card(
  //
  //     shape: chatCubit.listMessage[index].fromType ==
  //         "partner"
  //         ? const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(50),
  //           topRight: Radius.circular(50),
  //           bottomRight: Radius.circular(50),
  //         ))
  //         : const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(50),
  //           topRight: Radius.circular(50),
  //           bottomLeft: Radius.circular(50),
  //         )),
  //     elevation: 0,
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
  //       child:Consumer<ChatCubit>(
  //         builder:(context, value, child) {
  //           return Directionality(
  //             textDirection:
  //             chatCubit.listMessage[index].fromType ==
  //                 "partner"
  //                 ? TextDirection.rtl
  //                 : TextDirection.ltr,
  //             child:
  //             // AudioPlayer(
  //             //   source: chatCubit.listMessage[index].file!,
  //             //   onDelete: () {
  //             //     setState(() => showPlayer = false);
  //             //   },
  //             // )
  //             chatCubit.listMessage[index].file!
  //                 .startsWith('/chat-messages/')?
  //             VoiceMessage(
  //               meBgColor: HexColor("#8D93AB"),
  //               audioSrc: "${AppString.baseUrl}${chatCubit.listMessage[index].file!}",
  //               me: true, // Set message side.
  //               onPlay: () {
  //                 print("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
  //               }, // Do something when voice played.
  //             ):
  //             VoiceMessage(
  //               audioSrc: chatCubit.listMessage[index].file!,
  //               me: true, // Set message side.
  //               onPlay: () {
  //               }, // Do something when voice played.
  //             ),
  //           );
  //         },
  //       ),
  //
  //     ),
  //   );
  // } else {
  //   return Card(
  //     color: chatCubit.listMessage[index].fromType ==
  //         "partner"
  //         ? const Color(0xff8D93AB).withOpacity(0.5)
  //         : const Color(0xff8D93AB),
  //     shape: chatCubit.listMessage[index].fromType ==
  //         "partner"
  //         ? const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(50),
  //           topRight: Radius.circular(50),
  //           bottomRight: Radius.circular(50),
  //         ))
  //         : const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(
  //           topLeft: Radius.circular(50),
  //           topRight: Radius.circular(50),
  //           bottomLeft: Radius.circular(50),
  //         )),
  //     elevation: 0,
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 15.w),
  //       child: Text(
  //         textDirection:
  //         chatCubit.listMessage[index].fromType ==
  //             "partner"
  //             ? TextDirection.ltr
  //             : TextDirection.rtl,
  //         '${chatCubit.listMessage[index].message}',
  //         style: TextStyle(
  //           color:chatCubit.listMessage[index].fromType ==
  //               "partner"? Colors.black:Colors.white,
  //           fontSize: 13.sp,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  return Card(
    color: chatCubit.listMessage[index].fromType ==
        "partner"
        ? const Color(0xff8D93AB).withOpacity(0.5)
        : const Color(0xff8D93AB),
    shape: chatCubit.listMessage[index].fromType ==
        "partner"
        ? const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
          bottomRight: Radius.circular(50),
        ))
        : const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(50),
          topRight: Radius.circular(50),
          bottomLeft: Radius.circular(50),
        )),
    elevation: 0,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Text(
        textDirection:
        chatCubit.listMessage[index].fromType ==
            "partner"
            ? TextDirection.ltr
            : TextDirection.rtl,
        '${chatCubit.listMessage[index].message}',
        style: TextStyle(
          color:chatCubit.listMessage[index].fromType ==
              "partner"? Colors.black:Colors.white,
          fontSize: 13,
        ),
      ),
    ),
  );

}
// Future openFile({required String url,String? name})async
// {
//   final file=await downLoadFile(url: url,name: name);
//   if(file ==null)
//   {
//     return ;
//
//   }else{
//     // OpenFilex.open(file.path);
//   }
// }
//
// Future<File?> downLoadFile({required String url,String? name})async
// {
//   final appStorage=await getApplicationDocumentsDirectory();
//   final file=File("${appStorage.path}/$name");
//
//   try{
//     final response = await Dio().get(
//         url,
//         options: Options(
//           responseType: ResponseType.bytes,
//           followRedirects: false,
//           receiveTimeout: 0,
//         ));
//     final ref = file.openSync(mode: FileMode.write);
//     ref.writeFromSync(response.data);
//     await ref.close();
//     print(file);
//
//     return file;
//   }catch(e){
//     print(e);
//     return null;
//   }
// }