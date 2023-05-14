import 'dart:async';
import 'dart:convert';
import 'dart:io';


import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';


import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../service/pusher_services/dio_helper.dart';
import '../../service/pusher_services/pusher_service.dart';
import '../model/chat_id_model.dart';
import '../model/chat_message_model.dart';


class ChatCubit extends ChangeNotifier {
  ChatCubit({
    required  this.pusherChannel,
    required  this.pusherEventRideStatusUpdated,
    required this.userId,
    required this.accessToken,
    required this.userDeviceToken,
    required this.getChatIdUrl,
    required this.addChatMessageUrl,
    required this.getChatMessageUrl,
})  {
    print("food2");
    init();


    // await PusherService.instance.init(
    //   myApiKey: apiKey,
    //   myCluster: widget.cluster,
    // );
  }
  init()async{
    await DioHelper.init();
    print("food3");
  }

  int userId;
  String pusherChannel;
  String pusherEventRideStatusUpdated;
  String accessToken;
  String userDeviceToken;
  String getChatIdUrl;
  String addChatMessageUrl;
  String getChatMessageUrl;
  ChatIdModel? chatIdModel;
  ChatMessagesModel? chatMessagesModel;
  List<ChatMessagesData> listMessage=[];


  String time="";
  String date="";
  String imageName="";
  File? imageFile;
  String? fileName;
  File? file;
  File? AudioFile;
  String? audio;
  int page=1;

  bool loadingMore=false;





  late final PusherService _pusherService = PusherService.instance;
  late final String _pusherChannelNameRideStatusUpdates =pusherChannel;



  Future getChatId(
      { int? hallId,
      required int partnerId,
      required String partnerToken,
      }) async {


    await DioHelper.postData(url:getChatIdUrl,token:accessToken, data: {
      "hall_id": hallId,
      "partner_id": partnerId,
      "user_id": userId,
      "partner_device_token": partnerToken,
      "user_device_token": userDeviceToken
    }).then((value) {
      if (value.statusCode == 200) {
        print(value.data);
        chatIdModel = ChatIdModel.fromJson(value.data);
        getChatMessage(chatId: chatIdModel!.data!.id!);
      }
    }).catchError((onError) {
      print(onError);
    });
    notifyListeners();
  }


  // Add message
  Future addChatMessage(
      {required int chatId,
      required String messageType,
       String? message,
      required String partnerToken,
        MultipartFile? file,
        String? audioDuration,
        String? fileName,

      }) async {
    print("++++++++++++++++++++++++++++++");
    print("++++++++++++++++++++++++++++++");
    Map<String, dynamic> data = {
      "message_type":messageType,
      "message":message,
      "from_type":"user",
      "to_type":"partner",
      "halls_user_chat_id": chatId,
      "target_device_token": partnerToken,
      "file":file,
      "audio_duration":audioDuration,
      "file_name":fileName,
    };
    await DioHelper.postDataChatMessage(url: addChatMessageUrl,
        data: FormData.fromMap(data), headers: {
      'Authorization': 'Bearer ${accessToken}'
    }).then((value) {
      print(value?.data);
      print(value?.statusMessage);
      print(value?.statusCode);

      if (value?.statusCode == 200) {
        print(value?.data);
        print("addddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd");
        // emit(SuccessAddMessageChatState());
      }
    }).catchError((onError) {
      print(onError);
      // emit(ErrorAddMessageChatState());
    });
  }


  Future getChatMessage(
      {
      required int chatId,
      }) async {
    loadingMore=true;
    notifyListeners();
    await DioHelper.postData(url: getChatMessageUrl,token: accessToken, data: {
      "halls_user_chat_id": chatId,
      "enter_user_type": "user",
      "page":page,
    }).then((value) {
      if (value.statusCode == 200) {
        // print(value?.data);
        print("11111111111111111111111111111111111111111111");
        chatMessagesModel = ChatMessagesModel.fromJson(value.data);
        listMessage=listMessage + chatMessagesModel!.data!.data!;
        print("listMessage?[0].message");
        print(loadingMore);
        _subscribeToChannels();
        if(chatMessagesModel?.data?.nextPageUrl !=null) {
          page++;
        }
        loadingMore=false;
      }
    }).catchError((onError) {
      print(onError);
      loadingMore=false;

    });
    notifyListeners();


  }





  void _subscribeToChannels() async {
    await unSubscribeToChannels();
    // ride status updates channel.
    final PusherChannel _rideStatusUpdatesPusherChannel = await _pusherService
        .subscribe(channelName: _pusherChannelNameRideStatusUpdates);
    _rideStatusUpdatesPusherChannel.onEvent = (event) {
      debugPrint('starting [onEvent][RideComponentNotifier]...');
      final PusherEvent pusherEvent = event as PusherEvent;
      print("object");
      print("object");
      print("object");
      if (pusherEvent.eventName == pusherEventRideStatusUpdated) {
        // on ride status updated.
        print("data++++++++++++++++++++++++++++++");

        Map<String,dynamic> dataMessage = json.decode(event.data);
        // var newMess=ChatMessagesData.fromJson(data[]);
        // print(event.data["message"]["message_type"]);

          var newMess=ChatMessagesData.fromJson(dataMessage["message"]);


          print("object");
          if (newMess.fromType == "partner") {
            print("object");

            // chatMessagesModel?.data?.data?.insert(0, newMess);
            listMessage.insert(0, newMess);
            print(listMessage[0].message);
            print("data++++++++++++++++++++++++++++++1");
          }
        notifyListeners();




        // if (data != null &&
        //     data['message'] != null &&
        //     (data['message'] is List && (data['message'] as List).isNotEmpty)) {
        //   audioPlayer.play(BytesSource(soundBytes));
        //   ride = Ride.fromJson(data['message'][0]);
        //   if (ride.status == Constants.rideStatusRefusedByDriver ||
        //       ride.status == Constants.rideStatusCanceledByDriver ||
        //       ride.status == Constants.rideStatusCompleted) {
        //     if (ride.status == Constants.rideStatusCompleted) {
        //       showDialog(
        //         context: context,
        //         builder: (_) => RateDriverDialogComponent(
        //           driverId: ride.driverId!,
        //           rideId: ride.id!,
        //         ),
        //       );
        //     }
        //     ignoreRide();
        //   } else {
        //     _notifyRide();
        //   }
        // }
      }
    };
    // driver location updates channel.
    // final PusherChannel _driverLocationUpdatesPusherChannel =
    // await PusherService.instance
    //     .subscribe(channelName: _pusherChannelNameDriverLocationUpdates);
    // _driverLocationUpdatesPusherChannel.onEvent = (event) {
    //   debugPrint('starting [onEvent][RideComponentNotifier]...');
    //   final PusherEvent pusherEvent = event as PusherEvent;
    //   if (pusherEvent.eventName == Constants.pusherEventDriverLocationUpdated) {
    //     // on driver location updated.
    //     Map? data = jsonDecode(event.data);
    //     if (data != null &&
    //         data['message'] != null &&
    //         data['message']['lat'] != null &&
    //         data['message']['long'] != null) {
    //       double driverLatitude = data['message']['lat'];
    //       double driverLongitude = data['message']['long'];
    //       onDriverLocationUpdated(
    //           driverLatitude: driverLatitude, driverLongitude: driverLongitude);
    //     }
    //   }
    // };
  }


  Future<void> unSubscribeToChannels() async {
    print("unSubscribeToChannels");
    print(_pusherChannelNameRideStatusUpdates);

    await _pusherService.unsubscribe(
        channelName: "_pusherChannelNameRideStatusUpdates");

    debugPrint(
        'disconnected to $_pusherChannelNameRideStatusUpdates channel successfully...');



  }

  String convertTime({required int hour,required String minute})
  {
    int h;
    if(hour>12)
    {
      h=hour-12;
      return"${h}:${minute} ص ";
    }else if(hour==12) {
      return "${12}:${minute} ص ";
    }else if(hour==0){
      return "${12}:${minute}ص ";
    }else
    {
      return "${hour}:${minute} م ";
    }
  }

  sendTime({required int index})
  {
    int hour = int.parse(listMessage[index].createdAt!.substring(11, 13));
    String minute = listMessage[index].createdAt!.substring(14, 16);
    time=convertTime(hour: hour, minute: minute);
  }



  selectFile()async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
       file = File(result.files.single.path!);
      PlatformFile platformFile=result.files.first;
      fileName=platformFile.name;
      notifyListeners();

    } else {
      // User canceled the picker
      print("you not select file");
    }

  }

  clearFile()
  {
    file=null;
    notifyListeners();
  }

  selectImage()async{
    final ImagePicker _picker = ImagePicker();

    final XFile? images = await _picker.pickImage(source: ImageSource.camera);

    if(images !=null) {
      imageFile = File(images.path);
      imageName = images.name;
      print(images.path);
      print(imageFile!.path);
      notifyListeners();
    }
  }

  clearImage()
  {
    imageFile=null;
    notifyListeners();
  }


  setAudio(String newAudio)
  {
    audio=newAudio;
    notifyListeners();
  }

  selectAudio()async{

    AudioFile=File(audio!);
    print(AudioFile!.path);
    notifyListeners();
    }

  clearAudio()
  {
    AudioFile=null;
    notifyListeners();

  }









}
