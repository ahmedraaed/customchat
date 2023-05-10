import 'package:flutter/foundation.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';


class PusherService {
  static PusherService? _instance;
  late final PusherChannelsFlutter _pusherChannelsFlutter =
  PusherChannelsFlutter.getInstance();

  // private constructor.
  PusherService._();

  // singleton pattern.
  static PusherService get instance {
    if (_instance != null) return _instance!;
    return _instance = PusherService._();
  }

  // init.
  Future<void> init({
  required String myApiKey,
  required String myCluster,
}) async {
    try {
      await _pusherChannelsFlutter.init(
        apiKey: myApiKey,
        cluster: myCluster,
        onConnectionStateChange: (String currentState, String previousState) {
          debugPrint('starting [onConnectionStateChange][PusherService]...');
          debugPrint(
              "previousState: $previousState, currentState: $currentState");
        },
        onError: (String message, int? code, dynamic error) {
          debugPrint('starting [onError][PusherService]...');
          debugPrint("error: ${error?.toString()}");
          debugPrint("error: $message");
          debugPrint("error: $code");
        },
      );
    } catch (error) {
      // it's already initialized.
    }
    await _pusherChannelsFlutter.connect();
  }

  // subscribe to channel.
  Future<PusherChannel> subscribe({
    required String channelName,
  }) async {
    return await _pusherChannelsFlutter.subscribe(
      channelName: channelName,
      onSubscriptionSucceeded: (data) {
        debugPrint('connected to $channelName channel successfully...');
      },
      onSubscriptionError: () {
        debugPrint('failed to connect to $channelName...');
      },
    );
  }

  // unsubscribe to channel.
  Future<void> unsubscribe({
    required String channelName,
  }) async {
    return await _pusherChannelsFlutter.unsubscribe(channelName: channelName);
  }

  // disconnect.
  Future<void> disconnect() async {
    await _pusherChannelsFlutter.disconnect();
  }
}